alter table stu_acadrec
   drop constraint FK_STU_ACAD_REF_23073_STU_MAST 
go


alter table stu_address
   drop constraint FK_STU_ADDR_REF_12130_STU_DEMO 
go


alter table stu_demo
   drop constraint FK_STU_DEMO_REF_23034_STU_MAST 
go


alter table stu_dprog
   drop constraint FK_STU_DPRO_REF_23053_STU_MAST 
go


alter table stu_egrp_courses
   drop constraint fk_egrp_2_egrp_crs
go


alter table stu_egrp_courses
   drop constraint FK_STU_EGRP_REF_46007_STU_ACAD 
go


alter table stu_evalgrp
   drop constraint fk_stu_eval_2_mast 
go

alter table stu_marker_req
   drop constraint FK_STU_MARK_RELATION__STU_DPRO 
go


alter table stu_trans_degree
   drop constraint FK_STU_TRAN_REF_23058_STU_MAST 
go



truncate table stu_egrp_courses
go
truncate table stu_evalgrp
go
truncate table stu_acadrec
go
truncate table stu_marker_req
go
truncate table stu_dprog
go
truncate table stu_trans_degree
go
truncate table stu_address
go
truncate table stu_demo
go      


alter table stu_acadrec
   add constraint FK_STU_ACAD_REF_23073_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table stu_address
   add constraint FK_STU_ADDR_REF_12130_STU_DEMO foreign key (stu_mast_no, source_id)
      references stu_demo (stu_mast_no, source_id)
go


alter table stu_demo
   add constraint FK_STU_DEMO_REF_23034_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table stu_dprog
   add constraint FK_STU_DPRO_REF_23053_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table stu_egrp_courses
   add constraint fk_egrp_2_egrp_crs foreign key (stu_mast_no, evalgrp)
      references stu_evalgrp (stu_mast_no, evalgrp)
go


alter table stu_egrp_courses
   add constraint FK_STU_EGRP_REF_46007_STU_ACAD foreign key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
      references stu_acadrec (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
go


alter table stu_evalgrp
   add constraint fk_stu_eval_2_mast foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go

alter table stu_marker_req
   add constraint FK_STU_MARK_RELATION__STU_DPRO foreign key (stu_mast_no, instcd, dprog)
      references stu_dprog (stu_mast_no, instcd, dprog)
go


alter table stu_trans_degree
   add constraint FK_STU_TRAN_REF_23058_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go
