import streamlit as st
import ctypes

# Define the node structure in ctypes
class Node(ctypes.Structure):
    pass

Node._fields_ = [
    ("pointers", ctypes.POINTER(ctypes.c_void_p)),  
    ("keys", ctypes.POINTER(ctypes.c_int)),
    ("parent", ctypes.POINTER(Node)),
    ("is_leaf", ctypes.c_bool),
    ("num_keys", ctypes.c_int),
    ("next", ctypes.POINTER(Node))
]

# Load the shared library
bplus = ctypes.CDLL('./b_plus_tree.so')
bplus.insert.argtypes = [ctypes.POINTER(Node), ctypes.c_int, ctypes.c_int]
bplus.insert.restype = ctypes.POINTER(Node)
bplus.delete.argtypes = [ctypes.POINTER(Node), ctypes.c_int]
bplus.delete.restype = ctypes.POINTER(Node)
bplus.print_tree.argtypes = [ctypes.POINTER(Node)]
bplus.print_tree.restype = None

# Initialize root node
root_node = Node()
root_node.is_leaf = True
root_node.num_keys = 0
root_node.pointers = ctypes.cast(ctypes.pointer(ctypes.c_void_p()), ctypes.POINTER(ctypes.c_void_p))
root_node.keys = ctypes.pointer(ctypes.c_int(0))
root_node.parent = None
root_node.next = None

# Function to recursively print the B+ tree structure
def print_bplus_tree(node):
    if node.is_leaf:
        for i in range(node.num_keys):
            st.write(f'({node.keys[i]})', end=" ")
    else:
        for i in range(node.num_keys):
            print_bplus_tree(ctypes.cast(node.pointers[i], ctypes.POINTER(Node)))
            st.write(f'({node.keys[i]})', end=" ")
        print_bplus_tree(ctypes.cast(node.pointers[node.num_keys], ctypes.POINTER(Node)))

# Streamlit user interface for B+ tree operations
st.title('B+ Tree Management')

key = st.text_input('Key:', value='0')
key = int(key)  

value = st.text_input('Value (only needed for insert):', value='0')
value = int(value)  

col1, col2, col3 = st.columns(3)
with col1:
    if st.button('Insert'):
        new_root = bplus.insert(ctypes.byref(root_node), key, value)
        if new_root:
            st.success(f'Inserted key {key} with value {value}')
        else:
            st.error('Insert failed')

with col2:
    if st.button('Delete'):
        new_root = bplus.delete(ctypes.byref(root_node), key)
        if new_root:
            st.success(f'Deleted key {key}')
        else:
            st.error('Delete failed')

with col3:
    if st.button('Find'):
        # Placeholder for the find operation
        st.error('Find operation is not implemented.')

# Add a button to display the tree structure
if st.button('Print Tree'):
    st.write("B+ Tree Structure:")
    print_bplus_tree(root_node)