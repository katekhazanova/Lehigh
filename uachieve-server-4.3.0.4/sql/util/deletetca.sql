declare @idq char(2), @id char(8), @cd char(3), @source_id char(8), @source_cd char(3), @fyt char(6)
set @idq = '73'
set @id = 'MIAMI   '
set @cd = 'ISF'
set @source_id = '008558  '
set @source_cd = '   '
set @fyt = '00001 '

delete from tca_target
where tca_rule_seq_no in 
	(select int_seq_no
	from tca_rule
	where instidq = @idq
	and instid = @id
	and instcd = @cd
	and source_id = @source_id
	and source_cd = @source_cd
	and fyt = @fyt)

delete from tca_source
where tca_rule_seq_no in 
	(select int_seq_no
	from tca_rule
	where instidq = @idq
	and instid = @id
	and instcd = @cd
	and source_id = @source_id
	and source_cd = @source_cd
	and fyt = @fyt)

delete from tca_rule
where instidq = @idq
and instid = @id
and instcd = @cd
and source_id = @source_id
and source_cd = @source_cd
and fyt = @fyt

delete from tca_master
where instidq = @idq
and instid = @id
and instcd = @cd
and source_id = @source_id
and source_cd = @source_cd
and fyt = @fyt





			

