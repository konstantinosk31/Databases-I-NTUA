CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_all`()
BEGIN
	call mydb.for_loop_judges();
    call mydb.create_assignments();
    call mydb.populate_eval_for();
END