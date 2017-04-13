if not (exists(select * from information_schema.columns
                where table_name = 'job_queue_req'
                and column_name = 'force_schema_include'))
    begin
        alter table job_queue_req add force_schema_include char(1)
    end
go

if not (exists(select * from information_schema.columns
                where table_name = 'chart_categories'
                and column_name = 'force_schema_include'))
    begin
        alter table chart_categories add force_schema_include char(1)
    end
go