/*================================================================*/
/* DBMS name:      Microsoft SQL Server                           */
/* Created on:     8/13/2008 2:30:15 PM                           */
/* Last Updated:   6/05/2015                                      */
/*                                                                */
/* Script name:    uachieve_MSSQL_create_trg.sql                  */
/* Purpose:        Creates the u.achieve 4.3 insert and update    */
/*                 triggers.                                      */
/*                                                             	  */
/* Beginning with 4.2, we have moved all the security tables      */
/* and any other tables specific to u.achieve self-service to     */
/* the Dashboard installation scripts.                            */
/*                                                                */
/* This script now contains only those tables specific to the     */
/* u.achieve server.                                              */
/*                                                                */
/* Highlights: 	4.3	June 15, 2015                                 */
/*                                                                */
/*                * Removed version from create script names.     */
/*                * Removed int_seq_no from most job_queue PKs.   */
/*                * Added columns to job_queue tables to identify */
/*                  server host.                                  */
/*                * Added tca_segment and transfer_inst tables.   */
/*                * Change int_seq_no data type from numeric(9)   */
/*                  to numeric(18).                               */
/*                                                                */
/* Copyright(c) 1998-2015 CollegeSource, Inc. All Rights Reserved */
/*                                                                */
/*================================================================*/

/*  insert trigger "ti_com" for table "com"  */
create trigger ti_com on com for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_com" for table "com"  */
create trigger tu_com on com for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return
    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_crs_convert" for table "crs_convert"  */
create trigger ti_crs_convert on crs_convert for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update crs_convert
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from crs_convert t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_crs_convert" for table "crs_convert"  */
create trigger tu_crs_convert on crs_convert for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update crs_convert
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from crs_convert t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_dprog" for table "dprog"  */
create trigger ti_dprog on dprog for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_dprog" for table "dprog"  */
create trigger tu_dprog on dprog for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_dprog_req" for table "dprog_req"  */
create trigger ti_dprog_req on dprog_req for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update dprog_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog_req t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_dprog_req" for table "dprog_req"  */
create trigger tu_dprog_req on dprog_req for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update dprog_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog_req t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_gmaster" for table "gmaster"  */
create trigger ti_gmaster on gmaster for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_gmaster" for table "gmaster"  */
create trigger tu_gmaster on gmaster for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return
    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_job_queue_list" for table "job_queue_list"  */
create trigger ti_job_queue_list on job_queue_list for insert as
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
    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_job_queue_list" for table "job_queue_list"  */
create trigger tu_job_queue_list on job_queue_list for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_mastref" for table "mastref"  */
create trigger ti_mastref on mastref for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_mastref" for table "mastref"  */
create trigger tu_mastref on mastref for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_mastref_address" for table "mastref_address"  */
create trigger ti_mastref_address on mastref_address for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_mastref_address" for table "mastref_address"  */
create trigger tu_mastref_address on mastref_address for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return
    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_mastref_seg" for table "mastref_seg"  */
create trigger ti_mastref_seg on mastref_seg for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update mastref_seg
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref_seg t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_mastref_seg" for table "mastref_seg"  */
create trigger tu_mastref_seg on mastref_seg for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update mastref_seg
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref_seg t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_repeat" for table "repeat"  */
create trigger ti_repeat on repeat for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update repeat
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from repeat t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_repeat" for table "repeat"  */
create trigger tu_repeat on repeat for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update repeat
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from repeat t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_req_main" for table "req_main"  */
create trigger ti_req_main on req_main for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_req_main" for table "req_main"  */
create trigger tu_req_main on req_main for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_req_text" for table "req_text"  */
create trigger ti_req_text on req_text for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_text t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_req_text" for table "req_text"  */
create trigger tu_req_text on req_text for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_text t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_req_xy" for table "req_xy"  */
create trigger ti_req_xy on req_xy for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update req_xy
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_xy t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_req_xy" for table "req_xy"  */
create trigger tu_req_xy on req_xy for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update req_xy
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_xy t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_string" for table "string"  */
create trigger ti_string on string for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_string" for table "string"  */
create trigger tu_string on string for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return
    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_string_crse" for table "string_crse"  */
create trigger ti_string_crse on string_crse for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update string_crse
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from string_crse t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_string_crse" for table "string_crse"  */
create trigger tu_string_crse on string_crse for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update string_crse
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from string_crse t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_stu_acadrec" for table "stu_acadrec"  */
create trigger ti_stu_acadrec on stu_acadrec for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_stu_acadrec" for table "stu_acadrec"  */
create trigger tu_stu_acadrec on stu_acadrec for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_stu_address" for table "stu_address"  */
create trigger ti_stu_address on stu_address for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update stu_address
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_address t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_stu_address" for table "stu_address"  */
create trigger tu_stu_address on stu_address for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update stu_address
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_address t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_stu_demo" for table "stu_demo"  */
create trigger ti_stu_demo on stu_demo for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_studemo" for table "stu_demo"  */
create trigger tu_studemo on stu_demo for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_stu_dprog" for table "stu_dprog"  */
create trigger ti_stu_dprog on stu_dprog for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_stu_dprog" for table "stu_dprog"  */
create trigger tu_stu_dprog on stu_dprog for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_stu_eval_seg" for table "stu_evalgrp"  */
create trigger ti_stu_evalgrp on stu_evalgrp for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_stu_eval_seg" for table "stu_evalgrp"  */
create trigger tu_stu_eval_seg on stu_evalgrp for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
    select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go


/*  insert trigger "ti_stu_exc_courses" for table "stu_exc_courses"  */
create trigger ti_stu_exc_courses on stu_exc_courses for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go


/*  update trigger "tu_stu_exc_courses" for table "stu_exc_courses"  */
create trigger tu_stu_exc_courses on stu_exc_courses for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_stu_exceptions" for table "stu_exceptions"  */
create trigger ti_stu_exceptions on stu_exceptions for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_stu_exceptions" for table "stu_exceptions"  */
create trigger tu_stu_exceptions on stu_exceptions for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_stu_marker_req" for table "stu_marker_req"  */
create trigger ti_stu_marker_req on stu_marker_req for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_stu_marker_req" for table "stu_marker_req"  */
create trigger tu_stu_marker_req on stu_marker_req for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

    select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go


/*  insert trigger "ti_student_information" for table "stu_master"  */
create trigger ti_student_information on stu_master for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_student_information" for table "stu_master"  */
create trigger tu_student_information on stu_master for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)
    select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */

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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_stu_trans_degree" for table "stu_trans_degree"  */
create trigger ti_stu_trans_degree on stu_trans_degree for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update stu_trans_degree
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_trans_degree t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.user_seq_no = i.user_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_stu_transfer_degree" for table "stu_trans_degree"  */
create trigger tu_stu_transfer_degree on stu_trans_degree for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update stu_trans_degree
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_trans_degree t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.user_seq_no = i.user_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_sub_req" for table "sub_req"  */
create trigger ti_sub_req on sub_req for insert as
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
    /*  update "last saved" information */
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
/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_sub_req" for table "sub_req"  */
create trigger tu_sub_req on sub_req for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_sub_req_ar" for table "sub_req_ar"  */
create trigger ti_sub_req_ar on sub_req_ar for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update sub_req_ar
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_ar t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_sub_req_ar" for table "sub_req_ar"  */
create trigger tu_sub_req_ar on sub_req_ar for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update sub_req_ar
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_ar t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_sub_req_text" for table "sub_req_text"  */
create trigger ti_sub_req_text on sub_req_text for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update sub_req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_text t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_sub_req_text" for table "sub_req_text"  */
create trigger tu_sub_req_text on sub_req_text for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update sub_req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_text t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_tca_master" for table "tca_master"  */
create trigger ti_tca_master on tca_master for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_tca_master" for table "tca_master"  */


create trigger tu_tca_master on tca_master for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_tca_rule" for table "tca_rule"  */
create trigger ti_tca_rule on tca_rule for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update tca_rule
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_rule t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_tca_rule" for table "tca_rule"  */
create trigger tu_tca_rule on tca_rule for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update tca_rule
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_rule t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_tca_source" for table "tca_source"  */
create trigger ti_tca_source on tca_source for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update tca_source
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_source t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_tca_source" for table "tca_source"  */
create trigger tu_tca_source on tca_source for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update tca_source
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_source t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_tca_target" for table "tca_target"  */
create trigger ti_tca_target on tca_target for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update tca_target
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_target t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_tca_target" for table "tca_target"  */
create trigger tu_tca_target on tca_target for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update tca_target
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_target t, inserted i
    where t.int_seq_no = i.int_seq_no


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/* *** New with 4.3 *** */

/*  insert trigger "ti_transfer_inst" for table "transfer_inst"  */
create trigger ti_transfer_inst on transfer_inst for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update transfer_inst
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from transfer_inst t, inserted i
    where   t.instidq = i.instidq and
            t.instid = i.instid and
            t.instcd = i.instcd and
            t.source_id = i.source_id and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_transfer_inst" for table "transfer_inst"  */
create trigger tu_transfer_inst on transfer_inst for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update transfer_inst
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from transfer_inst t, inserted i
    where t.instidq = i.instidq and
            t.instid = i.instid and
            t.instcd = i.instcd and
            t.source_id = i.source_id

      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  insert trigger "ti_tca_segment" for table "tca_segment"  */
create trigger ti_tca_segment on tca_segment for insert as
begin
    declare
       
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update tca_segment
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_segment t, inserted i
    where t.instidq = i.instidq and
            t.instid = i.instid and
            t.instcd = i.instcd and
            t.source_id = i.source_id and
            t.source_cd = i.source_cd and
            t.dpmask = i.dpmask and
            t.fyt = i.fyt and
            t.tseg = i.tseg and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go


/*  update trigger "tu_tca_segment" for table "tca_segment"  */
create trigger tu_tca_segment on tca_segment for update as
begin
   declare
      
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update tca_segment
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_segment t, inserted i
    where t.instidq = i.instidq and
            t.instid = i.instid and
            t.instcd = i.instcd and
            t.source_id = i.source_id and
            t.source_cd = i.source_cd and
            t.dpmask = i.dpmask and
            t.fyt = i.fyt and
            t.tseg = i.tseg

      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go


/* ******************* */
/* New with DARwin 3.5 */
/* ******************* */

/*  insert trigger "ti_chart_cat" for table "chart_categories"  */
create trigger ti_chart_cat on chart_categories for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
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

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

/*  update trigger "tu_chart_cat" for table "chart_categories"  */
create trigger tu_chart_cat on chart_categories for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update chart_categories
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from chart_categories c, inserted i
    where c.instidq = i.instidq and
          c.instid = i.instid and
          c.instcd = i.instcd and
          c.category_code = i.category_code


      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go
