alter table req_xy add series char(1)
go
alter trigger ti_com on com for insert as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update com
        set last_mod_user = user_name()
        from com t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.comkey = i.comkey and
              t.comfield = i.comfield

    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update com
        set last_mod_date = getdate()
        from com t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.comkey = i.comkey and
              t.comfield = i.comfield

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_com on com for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return
    if not update(last_mod_user)
        update com
        set last_mod_user = user_name()
        from com t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.comkey = i.comkey and
              t.comfield = i.comfield

    if not update(last_mod_date)
        update com
        set last_mod_date = getdate()
        from com t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.comkey = i.comkey and
              t.comfield = i.comfield

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_crs_convert on crs_convert for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return
    update crs_convert
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from crs_convert t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_crs_convert on crs_convert for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
    
	update crs_convert
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from crs_convert t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_dprog on dprog for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update dprog
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.dprog = i.dprog and
          t.dpfyt = i.dpfyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_dprog on dprog for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
                  
    update dprog
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.dprog = i.dprog and
          t.dpfyt = i.dpfyt

      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_dprog_req on dprog_req for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update dprog_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog_req t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_dprog_req on dprog_req for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update dprog_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog_req t, inserted i
    where t.int_seq_no = i.int_seq_no

      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_gmaster on gmaster for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update gmaster
        set last_mod_user = user_name()
        from gmaster t, inserted i
        where t.int_seq_no = i.int_seq_no
    
   if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update gmaster
        set last_mod_date = getdate()
        from gmaster t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_gmaster on gmaster for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update gmaster
        set last_mod_user = user_name()
        from gmaster t, inserted i
        where t.int_seq_no = i.int_seq_no
    
    if not update(last_mod_date)
        update gmaster
        set last_mod_date = getdate()
        from gmaster t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_job_queue_list on job_queue_list for insert as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update job_queue_list
        set last_mod_user = user_name()
        from job_queue_list t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.jobid = i.jobid and
              t.userid = i.userid

    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update job_queue_list
        set last_mod_date = getdate()
        from job_queue_list t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.jobid = i.jobid and
              t.userid = i.userid

     return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_job_queue_list on job_queue_list for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update job_queue_list
        set last_mod_user = user_name()
        from job_queue_list t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.jobid = i.jobid and
              t.userid = i.userid

    if not update(last_mod_date)
        update job_queue_list
        set last_mod_date = getdate()
        from job_queue_list t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.jobid = i.jobid and
              t.userid = i.userid

     return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_mastref on mastref for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    update mastref
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.mrfyt = i.mrfyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_mastref on mastref for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update mastref
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.mrfyt = i.mrfyt


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_mastref_address on mastref_address for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update mastref_address
        set last_mod_user = user_name()
        from mastref_address t, inserted i
        where t.int_seq_no = i.int_seq_no
    
     if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update mastref_address
        set last_mod_date = getdate()
        from mastref_address t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_mastref_address on mastref_address for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update mastref_address
        set last_mod_user = user_name()
        from mastref_address t, inserted i
        where t.int_seq_no = i.int_seq_no
    
    if not update(last_mod_date)
        update mastref_address
        set last_mod_date = getdate()
        from mastref_address t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_mastref_seg on mastref_seg for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return
    update mastref_seg
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref_seg t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_mastref_seg on mastref_seg for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update mastref_seg
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref_seg t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_repeat on repeat for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return
    
    update repeat
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from repeat t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_repeat on repeat for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update repeat
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from repeat t, inserted i
    where t.int_seq_no = i.int_seq_no

      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_req_main on req_main for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update req_main
        set last_mod_user = user_name()
        from req_main t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.rname = i.rname and
              t.rqfyt = i.rqfyt

    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update req_main
        set last_mod_date = getdate()
        from req_main t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.rname = i.rname and
              t.rqfyt = i.rqfyt

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_req_main on req_main for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update req_main
        set last_mod_user = user_name()
        from req_main t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.rname = i.rname and
              t.rqfyt = i.rqfyt

    if not update(last_mod_date)
        update req_main
        set last_mod_date = getdate()
        from req_main t, inserted i
        where t.instidq = i.instidq and
              t.instid = i.instid and
              t.instcd = i.instcd and
              t.rname = i.rname and
              t.rqfyt = i.rqfyt

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_req_text on req_text for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_text t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_req_text on req_text for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_text t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_req_xy on req_xy for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return
    
    update req_xy
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_xy t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_req_xy on req_xy for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update req_xy
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_xy t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_string on string for insert as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update string
        set last_mod_user = user_name()
        from string t, inserted i
        where t.int_seq_no = i.int_seq_no

    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update string
        set last_mod_date = getdate()
        from string t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_string on string for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update string
        set last_mod_user = user_name()
        from string t, inserted i
        where t.int_seq_no = i.int_seq_no

    if not update(last_mod_date)
        update string
        set last_mod_date = getdate()
        from string t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_string_crse on string_crse for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update string_crse
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from string_crse t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_string_crse on string_crse for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update string_crse
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from string_crse t, inserted i
    where t.int_seq_no = i.int_seq_no
      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_acadrec on stu_acadrec for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update stu_acadrec
        set last_mod_user = user_name()
        from stu_acadrec t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.source_id = i.source_id and
              t.source_cd = i.source_cd and
              t.cdpmask = i.cdpmask and
              t.crs_yt = i.crs_yt and
              t.crs_num = i.crs_num and
              t.crs_seq = i.crs_seq

    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update stu_acadrec
        set last_mod_date = getdate()
        from stu_acadrec t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.source_id = i.source_id and
              t.source_cd = i.source_cd and
              t.cdpmask = i.cdpmask and
              t.crs_yt = i.crs_yt and
              t.crs_num = i.crs_num and
              t.crs_seq = i.crs_seq

      return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_stu_acadrec on stu_acadrec for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update stu_acadrec
        set last_mod_user = user_name()
        from stu_acadrec t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.source_id = i.source_id and
              t.source_cd = i.source_cd and
              t.cdpmask = i.cdpmask and
              t.crs_yt = i.crs_yt and
              t.crs_num = i.crs_num and
              t.crs_seq = i.crs_seq

    if not update(last_mod_date)
        update stu_acadrec
        set last_mod_date = getdate()
        from stu_acadrec t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.source_id = i.source_id and
              t.source_cd = i.source_cd and
              t.cdpmask = i.cdpmask and
              t.crs_yt = i.crs_yt and
              t.crs_num = i.crs_num and
              t.crs_seq = i.crs_seq

      return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_address on stu_address for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update stu_address
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_address t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_stu_address on stu_address for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update stu_address
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_address t, inserted i
    where t.int_seq_no = i.int_seq_no

      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_demo on stu_demo for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update stu_demo
        set last_mod_user = user_name()
        from stu_demo t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.source_id = i.source_id

   if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update stu_demo
        set last_mod_date = getdate()
        from stu_demo t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.source_id = i.source_id

      return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_studemo on stu_demo for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return


    if not update(last_mod_user)
        update stu_demo
        set last_mod_user = user_name()
        from stu_demo t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.source_id = i.source_id

    if not update(last_mod_date)
        update stu_demo
        set last_mod_date = getdate()
        from stu_demo t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.source_id = i.source_id

      return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_dprog on stu_dprog for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update stu_dprog
        set last_mod_user = user_name()
        from stu_dprog t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.instcd = i.instcd and
              t.dprog = i.dprog

   if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update stu_dprog
        set last_mod_date = getdate()
        from stu_dprog t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.instcd = i.instcd and
              t.dprog = i.dprog

      return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_stu_dprog on stu_dprog for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return


    if not update(last_mod_user)
        update stu_dprog
        set last_mod_user = user_name()
        from stu_dprog t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.instcd = i.instcd and
              t.dprog = i.dprog

    if not update(last_mod_date)
        update stu_dprog
        set last_mod_date = getdate()
        from stu_dprog t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.instcd = i.instcd and
              t.dprog = i.dprog

      return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_evalgrp on stu_evalgrp for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update stu_evalgrp
        set last_mod_user = user_name()
        from stu_evalgrp t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.evalgrp = i.evalgrp

   if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update stu_evalgrp
        set last_mod_date = getdate()
        from stu_evalgrp t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.evalgrp = i.evalgrp

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_stu_eval_seg on stu_evalgrp for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
    select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update stu_evalgrp
        set last_mod_user = user_name()
        from stu_evalgrp t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.evalgrp = i.evalgrp

    if not update(last_mod_date)
        update stu_evalgrp
        set last_mod_date = getdate()
        from stu_evalgrp t, inserted i
        where t.stu_mast_no = i.stu_mast_no and
              t.evalgrp = i.evalgrp

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_exc_courses on stu_exc_courses for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update stu_exc_courses
        set last_mod_user = user_name()
        from stu_exc_courses t, inserted i
        where t.int_seq_no = i.int_seq_no

    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update stu_exc_courses
        set last_mod_date = getdate()
        from stu_exc_courses t, inserted i
        where t.int_seq_no = i.int_seq_no

     return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_stu_exc_courses on stu_exc_courses for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update stu_exc_courses
        set last_mod_user = user_name()
        from stu_exc_courses t, inserted i
        where t.int_seq_no = i.int_seq_no

    if not update(last_mod_date)
        update stu_exc_courses
        set last_mod_date = getdate()
        from stu_exc_courses t, inserted i
        where t.int_seq_no = i.int_seq_no

     return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_exceptions on stu_exceptions for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update stu_exceptions
        set last_mod_user = user_name()
        from stu_exceptions t, inserted i
        where t.int_seq_no = i.int_seq_no
    
    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update stu_exceptions
        set last_mod_date = getdate()
        from stu_exceptions t, inserted i
        where t.int_seq_no = i.int_seq_no
    
    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_stu_exceptions on stu_exceptions for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update stu_exceptions
        set last_mod_user = user_name()
        from stu_exceptions t, inserted i
        where t.int_seq_no = i.int_seq_no
    
    if not update(last_mod_date)
        update stu_exceptions
        set last_mod_date = getdate()
        from stu_exceptions t, inserted i
        where t.int_seq_no = i.int_seq_no
    
    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_marker_req on stu_marker_req for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update stu_marker_req
        set last_mod_user = user_name()
        from stu_marker_req t, inserted i
        where t.int_seq_no = i.int_seq_no

    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update stu_marker_req
        set last_mod_date = getdate()
        from stu_marker_req t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_stu_marker_req on stu_marker_req for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

    select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update stu_marker_req
        set last_mod_user = user_name()
        from stu_marker_req t, inserted i
        where t.int_seq_no = i.int_seq_no

    if not update(last_mod_date)
        update stu_marker_req
        set last_mod_date = getdate()
        from stu_marker_req t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_student_information on stu_master for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update stu_master
        set last_mod_user = user_name()
        from stu_master t, inserted i
        where t.int_seq_no = i.int_seq_no
    
     if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update stu_master
        set last_mod_date  = getdate()
        from stu_master t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_student_information on stu_master for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
    select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update stu_master
        set last_mod_user = user_name()
        from stu_master t, inserted i
        where t.int_seq_no = i.int_seq_no
    
    if not update(last_mod_date)
        update stu_master
        set last_mod_date  = getdate()
        from stu_master t, inserted i
        where t.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_stu_trans_degree on stu_trans_degree for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return
       
    update stu_trans_degree
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_trans_degree t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.user_seq_no = i.user_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_stu_transfer_degree on stu_trans_degree for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update stu_trans_degree
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_trans_degree t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.user_seq_no = i.user_seq_no

      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_sub_req on sub_req for insert as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update sub_req
        set last_mod_user = user_name()
        from sub_req s, inserted i
        where s.int_seq_no = i.int_seq_no

    if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update sub_req
        set last_mod_date = getdate()
        from sub_req s, inserted i
        where s.int_seq_no = i.int_seq_no

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_sub_req on sub_req for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
    	update sub_req
        set last_mod_user = user_name()
        from sub_req s, inserted i
        where s.int_seq_no = i.int_seq_no

     if not update(last_mod_date)
    	update sub_req
        set last_mod_date = getdate()
        from sub_req s, inserted i
        where s.int_seq_no = i.int_seq_no

      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_sub_req_ar on sub_req_ar for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update sub_req_ar
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_ar t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_sub_req_ar on sub_req_ar for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update sub_req_ar
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_ar t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_sub_req_text on sub_req_text for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update sub_req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_text t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_sub_req_text on sub_req_text for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update sub_req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_text t, inserted i
    where t.int_seq_no = i.int_seq_no

      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_tca_master on tca_master for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    update tca_master
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_master t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.dpmask = i.dpmask and
          t.fyt = i.fyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_tca_master on tca_master for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update tca_master
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_master t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.dpmask = i.dpmask and
          t.fyt = i.fyt

      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_tca_rule on tca_rule for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update tca_rule
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_rule t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_tca_rule on tca_rule for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update tca_rule
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_rule t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_tca_source on tca_source for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update tca_source
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_source t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_tca_source on tca_source for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update tca_source
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_source t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_tca_target on tca_target for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update tca_target
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_target t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_tca_target on tca_target for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update tca_target
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_target t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_chart_cat on chart_categories for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    update chart_categories
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from chart_categories c, inserted i
    where c.instidq = i.instidq and
          c.instid = i.instid and
          c.instcd = i.instcd and
          c.category_code = i.category_code and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_chart_cat on chart_categories for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

	if not update(last_mod_user) AND not update (last_mod_date)          
             
    update chart_categories
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from chart_categories c, inserted i
    where c.instidq = i.instidq and
          c.instid = i.instid and
          c.instcd = i.instcd and
          c.category_code = i.category_code


      return

error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger ti_whatif_course on whatif_courses for insert as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
      @lmuser   varchar(30),
      @lmdate   datetime
    
    select  @numrows = @@rowcount
    if @numrows = 0
       return
    select @lmuser = i.last_mod_user, @lmdate = i.last_mod_date
        from inserted i
    if (@lmuser IS NULL OR LTRIM(@lmuser) = '')
        update whatif_courses
        set last_mod_user = user_name()
        from whatif_courses w, inserted i
        where w.stu_mast_no = i.stu_mast_no and
              w.source_id = i.source_id and
              w.source_cd = i.source_cd and
              w.cdpmask = i.cdpmask and
              w.crs_yt = i.crs_yt and
              w.crs_num = i.crs_num and
              w.crs_seq = i.crs_seq
    
     if (@lmdate IS NULL OR LTRIM(@lmdate) = '')
        update whatif_courses
        set last_mod_date = getdate()
        from whatif_courses w, inserted i
        where w.stu_mast_no = i.stu_mast_no and
              w.source_id = i.source_id and
              w.source_cd = i.source_cd and
              w.cdpmask = i.cdpmask and
              w.crs_yt = i.crs_yt and
              w.crs_num = i.crs_num and
              w.crs_seq = i.crs_seq

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

alter trigger tu_whatif_course on whatif_courses for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
    select  @numrows = @@rowcount
      if @numrows = 0
         return

    if not update(last_mod_user)
        update whatif_courses
        set last_mod_user = user_name()
        from whatif_courses w, inserted i
        where w.stu_mast_no = i.stu_mast_no and
              w.source_id = i.source_id and
              w.source_cd = i.source_cd and
              w.cdpmask = i.cdpmask and
              w.crs_yt = i.crs_yt and
              w.crs_num = i.crs_num and
              w.crs_seq = i.crs_seq
    
    if not update(last_mod_date)
        update whatif_courses
        set last_mod_date = getdate()
        from whatif_courses w, inserted i
        where w.stu_mast_no = i.stu_mast_no and
              w.source_id = i.source_id and
              w.source_cd = i.source_cd and
              w.cdpmask = i.cdpmask and
              w.crs_yt = i.crs_yt and
              w.crs_num = i.crs_num and
              w.crs_seq = i.crs_seq

    return
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
