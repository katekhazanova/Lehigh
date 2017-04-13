update tca_rule r
set tseg = (select substr(s.course, 1, nvl((select m.deptend
                                            from mastref m
                                            where m.instidq = r.instidq
                                            and m.instid = r.instid
                                            and m.instcd = r.instcd
                                            and m.source_id = r.source_id
                                            and m.source_cd = r.source_cd
                                            and m.mrfyt <= r.fyt 
                                            and m.lyt >= r.fyt),3))
            from tca_source s
            where s.tca_rule_seq_no = r.int_seq_no
            and s.user_seq_no = 1);
				


