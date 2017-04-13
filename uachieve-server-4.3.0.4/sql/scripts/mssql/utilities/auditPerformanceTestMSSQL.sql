//  Audit Throughput Test
//  
//  Selects random students from stu_master and submits audit requests.
//  
//  The number of students randomly selected is determined by input_num_audits.
//
//  The audit submissions are evenly spread across input_time_span (minutes) 
//  in an effort to simulate student demand.
//

//  Set the number of audits to run and the time period to cover during the test
declare @input_num_audits       int   = 3,               //  total number of audits to submit
        @input_time_span        int   = 1;               //  spread total audits over x minutes

//  Modify the following variables to match your u.achieve environment
declare
        @my_instidq             char(2)     = '73',             //  institution identity qualifier
        @my_instid              char(8)     = 'TEST40',         //  institution identity
        @my_instcd              char(3)     = ' ',              //  institution code (sub-identifier)

        @my_servername          char(10)    = 'DAP-UCLA',         //  u.achieve servername (defined in daemonContext.xml)
        @my_comkey              char(5)     = '40TST',          //  u.achieve com key for run

        @my_evalsw              char(1)     = 'D';              //  type of audit run (job_queue_detail.evalsw)


//  ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***
//  *** STOP!!  Values below are calculated and should NOT be modified manually
//  ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***
declare
    @time_span_seconds          numeric(10)  = 60,               //  calculated from input_time_span
    @sleep_btwn_audits          numeric(5)   = 1,                //  calculated sleep time
    @audits_per_loop            numeric(5)   = 1,                //  
    @audits_this_loop           numeric(5)   = 0,                //  
    @pending_count              numeric(5)   = 1,                //  count of audits submitted but not yet completed

    @stuno                      char(13)    = ' ',
    @my_jobid                   char(16)    = ' ',

    @start_time                 datetime2,                      //  time first audit request is inserted
    @insert_end_time            datetime2,                      //  time last audit request is inserted
    @audit_end_time             datetime2,                      //  time last audit completed running
    @diff                       int;                            //  temp variable used for time differences

declare @now datetime2 = sysdatetime()
declare @today datetime2 = convert(date, @now)
declare @currentyear int =  datepart(year, @now)
declare @jan1 datetime2 =  datefromparts(@currentyear, 1, 1)



//  cursor for randomly selecting x students from u.achieve's stu_master table.
//  doing the join to stu_dprog so we only get students that have a stu_dprog record.

begin

    declare 
        curs_students cursor for
            select top (@input_num_audits) stuno 
            from stu_master m
            join stu_dprog d on m.int_seq_no = d.stu_mast_no
            where m.instidq = @my_instidq 
            and m.instid = @my_instid
            order by rand() 



    //  Oracle only allows the sleep function for integer values, so we can't sleep
    //  for fractional seconds.  In order to simulate submitting an audit every half-
    //  second, we'll submit 2 audits and sleep for one second.  The following 
    //  if-then-else loop determines if we need to submit more than one audit per
    //  second, and if so, how many in each loop.

    //  calculating the number of audits that need to be inserted with each loop
    set @time_span_seconds = @input_time_span * 60

    // submitting less than or equal one audit per second
    if @time_span_seconds >= @input_num_audits
        begin
            set @sleep_btwn_audits = (@time_span_seconds / @input_num_audits)
            set @audits_per_loop = 1
        end
    else
        // submitting more than one audit per second
        begin
            set @sleep_btwn_audits = 1
            set @audits_per_loop = @input_num_audits / @time_span_seconds
        end

    declare @waitdelay datetime = timefromparts(0,0,@sleep_btwn_audits,0,0)

    // A little formatted output describing the setup
    print 'Begin inserting audit requests...'
    print 'Total audits to be inserted: ' + cast(@input_num_audits as varchar)
    print 'Insert time span (minutes) : ' + cast(@input_time_span as varchar)
    print ' '

    print '                                Start Time '

    set @start_time = sysdatetime()
    print 'Inserting and processing audits: '  + convert(varchar(20), @start_time, 108)
    print ' '

    print '                                 End Time      Elapsed'

    //  Start inserting audits
    open curs_students
    fetch next from curs_students into @stuno

    if @@fetch_status <> 0
        begin
            print '  NO STUDENTS SELECTED - EXIT CURSOR'
        end

    while @@fetch_status = 0
        begin

            set @now = sysdatetime()
            set @audits_this_loop = @audits_this_loop + 1
            set @my_jobid = 'PRF'
                            + convert(char(2), datediff(year, '2000-01-01', @now))
                            + replace(str(datediff(day, @jan1, @now), 3), space(1), '0') 
                            + replace(str(datediff(s, @today, @now), 5), space(1), '0')
                            + replace(str(@audits_this_loop, 3), space(1), '0')
    
            begin transaction insert_tran
        //  insert new audit request with 'H'old status
            insert into job_queue_list
                (INSTIDQ, INSTID, INSTCD, JOBID, USERID, STATUS, PRIORITY, SERVERNAME)
            values  (@my_instidq, @my_instid, ' ', @my_jobid, 'Performance Test', 'H', 50, @my_servername)
 
            insert into job_queue_detail
                (INSTIDQ, INSTID, instcd, jobid, USERID, USER_SEQ_NO, STUNO, COMKEY, EVALSW)
            values  (@my_instidq, @my_instid, @my_instcd, @my_jobid, 'Performance Test', 1, @stuno, @my_comkey, @my_evalsw)
            


        //  update request status so daemon will find it
            update job_queue_list
             set status = 'N'
                where JOBID = @my_jobid

            commit transaction insert_tran
        
        //  is it time to sleep, or should we submit another audit first?
            if @audits_this_loop >= @audits_per_loop
                begin
                    waitfor delay @waitdelay
                    set @audits_this_loop = 0
                end
            
            fetch next from curs_students into @stuno

        end // while

    // clean up cursor
    close curs_students 
    deallocate curs_students    

    //  At this point, all the audits have been submitted

    //  Formatting elapsed time for display
    set @insert_end_time = sysdatetime()
    set @diff = datediff(s, @start_time, @insert_end_time)
    print'Inserting audits:                ' + convert(varchar(20), @insert_end_time, 108) + '   ' + convert(varchar(10), @diff, 108)

    //  Have audits finished processing yet?
    while @pending_count > 0
        begin
            set @pending_count = (
                select count(*)
                from job_queue_list 
                where jobid like 'PRF%' 
                and status in ('N', 'Q', 'X'))

            // sleep for 1 second then check again
            waitfor delay '00:00:01'
        end

    //  All done - formatting results output
    set @audit_end_time = sysdatetime()

    set @diff = datediff(s, @start_time, @audit_end_time)
    print'Processing audits:               ' + convert(varchar(20), @audit_end_time, 108) + '   ' +  convert(varchar(10), @diff, 108)

    set @diff = datediff(s, @insert_end_time, @audit_end_time)
    print'                                            -----------'
    print'Extra time required to process audits:      ' + convert(varchar(10), @diff, 108)

end
go
