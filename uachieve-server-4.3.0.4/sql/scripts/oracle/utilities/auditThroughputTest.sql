//  Audit Throughput Test
//  
//  Selects random students from stu_master and submits audit requests.
//  
//  The number of students randomly selected is determined by input_num_audits.
//
//  The audit submissions are evenly spread across input_time_span (minutes) 
//  in an effort to simulate student demand.
//

declare

    input_num_audits    constant    number(5)   := 2;                      //  total number of audits to submit
    input_time_span     constant    number(5)   := 1;                       //  spread total audits over x minutes

    //  Modify the following variables to match your u.achieve environment
    my_instidq  constant    stu_master.instidq%TYPE := '73';                //  institution identity qualifier
    my_instid   constant    stu_master.instid%TYPE  := 'TEST40';            //  institution identity
    my_instcd   constant    dprog.instcd%TYPE       := ' ';                 //  institution code (sub-identifier)

    my_servername constant  job_queue_list.servername%TYPE  := 'DAP';    //  u.achieve servername (defined in daemonContext.xml)
    my_comkey   constant    job_queue_list.comkey%TYPE      := '40TST';     //  u.achieve com key for run

    my_evalsw   constant    job_queue_detail.evalsw%TYPE    := 'D';         //  type of audit run (job_queue_detail.evalsw)


//  ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***
//  *** STOP!!  Values below are calculated and should NOT be modified manually
//  ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***   ***
    time_span_seconds               number(10)  := 60;  //  calculated from input_time_span
    sleep_btwn_audits               number(5)   := 1;   //  calculated sleep time
    audits_per_loop                 number(5)   := 1;   //  
    audits_this_loop                number(5)   := 0;   //  
    pending_count                   number(5)   := 1;   //  count of audits submitted but not yet completed

    my_jobid                job_queue_list.jobid%Type := ' ';

    start_time          timestamp;                      //  time first audit request is inserted
    insert_end_time     timestamp;                      //  time last audit request is inserted
    audit_end_time      timestamp;                      //  time last audit completed running
    diff                interval day(0) to second(0);   //  temp variable used for time differences

    //  cursor for randomly selecting x students from u.achieve's stu_master table.
    //  doing the join to stu_dprog so we only get students that have a stu_dprog record.
    cursor curs_students is
        select stuno 
        from (
                select stuno 
                from stu_master m
                join stu_dprog d on m.int_seq_no = d.stu_mast_no
                where m.instidq = my_instidq 
                and m.instid = my_instid
                order by dbms_random.value)
        where rownum <= input_num_audits;

begin
    //  Oracle only allows the sleep function for integer values, so we can't sleep
    //  for fractional seconds.  In order to simulate submitting an audit every half-
    //  second, we'll submit 2 audits and sleep for one second.  The following 
    //  if-then-else loop determines if we need to submit more than one audit per
    //  second, and if so, how many in each loop.

    //  calculating the number of audits that need to be inserted with each loop
    time_span_seconds := input_time_span * 60;

    if time_span_seconds >= input_num_audits then
        // submitting less than or equal one audit per second
        begin
            sleep_btwn_audits := time_span_seconds / input_num_audits;
            audits_per_loop := 1;
        end;
    else
        // submitting more than one audit per second
        begin
            sleep_btwn_audits := 1;
            audits_per_loop := input_num_audits / time_span_seconds;
        end;
    end if;
        

    // A little formatted output describing the setup
    dbms_output.put_line('Begin inserting audit requests...');
    dbms_output.put_line('Total audits to be inserted: ' || input_num_audits);
    dbms_output.put_line('Insert time span (minutes) : ' || input_time_span);
    dbms_output.put_line(' ');

    dbms_output.put_line('                                Start Time ');

    select current_timestamp into start_time from dual;
    dbms_output.put_line('Inserting and processing audits: ' || to_char(start_time, 'HH24:MI:SS'));
    dbms_output.put_line(' ');

    dbms_output.put_line('                                 End Time      Elapsed');

    //  Start inserting audits
    for student in curs_students loop

        audits_this_loop := audits_this_loop + 1;

        select 'PRF' || TO_CHAR (CURRENT_TIMESTAMP, 'YYDDDSSSSS') || lpad(audits_this_loop, 3, '0') INTO my_jobid FROM DUAL;
    
        //  insert new audit request with 'H'old status
        insert into job_queue_list
                (INSTIDQ, INSTID, INSTCD, JOBID, USERID, STATUS, PRIORITY, SERVERNAME)
        values  (my_instidq, my_instid, ' ', my_jobid, 'Performance Test', 'H', 50, my_servername);
 
        insert into job_queue_detail
                (INSTIDQ, INSTID, instcd, jobid, USERID, USER_SEQ_NO, STUNO, COMKEY, EVALSW)
        values  (my_instidq, my_instid, my_instcd, my_jobid, 'Performance Test', 1, student.stuno, my_comkey, my_evalsw);

        //  update request status so daemon will find it
        update job_queue_list
            set status = 'N'
            where JOBID = my_jobid;

        commit;
        
        //  is it time to sleep, or should we submit another audit first?
        if (audits_this_loop >= audits_per_loop) then 
            begin
                dbms_lock.sleep(sleep_btwn_audits);
                audits_this_loop := 0;
            end;
        end if;
            
    end loop;

    //  At this point, all the audits have been submitted

    //  Formatting elapsed time for display
    select current_timestamp into insert_end_time from dual;
    select insert_end_time - start_time into diff from dual;
    dbms_output.put_line('Inserting audits:                ' || to_char(insert_end_time, 'HH24:MI:SS') || '   ' || diff);

    //  Have audits finished processing yet?
    while pending_count > 0 loop
        begin
            select count(*) into pending_count
            from job_queue_list 
            where jobid like 'PRF%' 
            and status in ('N', 'Q', 'X');

            // sleep for 1 second then check again
            dbms_lock.sleep(1);
        end;
    end loop;

    //  All done - formatting results output
    select current_timestamp into audit_end_time from dual;

    select audit_end_time - start_time into diff from dual;
    dbms_output.put_line('Processing audits:               ' || to_char(audit_end_time, 'HH24:MI:SS') || '   ' || diff);

    select audit_end_time - insert_end_time into diff from dual;
    dbms_output.put_line('                                            -----------');
    dbms_output.put_line('Extra time required to process audits:      ' || diff);

end;
