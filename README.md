sql-practice 

<h1>SQL NOTES</h1>


<h2>SQL WINDOW WITH ROWS BETWEEN</h2>

Window function allow sliding window frames

<u>Code</u>
SELECT <column_1>, <column_2>,
  OVER (
    PARTITION BY <...> 
    ORDER BY <...> 
        < sliding_window_frame >) <window_column_alias>
FROM <table_name>;

ROWS Clause: Syntax and Options
ROWS BETWEEN lower_bound and upper_bound

- UNBOUNDED PRECEDING
- n PRECEDING
- CURRENT ROW
- n FOLLOWING
- UNBOUNDED FOLLOWING

Example :-
SELECT date, revenue,
    SUM(revenue) OVER (
      ORDER BY date
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) running_total
FROM sales
ORDER BY date;


<h2>WAL vs rollback journal</h2>

There are 2 opposite ways to rollback the database to a previous state: "Rollback Journal" and "Write-ahead log".

<h3>Rollback Journal</h3>

- make a copy of the original database content and save it in a separate file, i.e. rollback journal, then write the new values into database directly.
- A COMMIT occurs when the rollback journal is deleted.
- rollback: copy the content in rollback journal back to database.

<h3>Write-ahead-log</h3>

- changes are appended to the write-ahead log file.
- A COMMIT occurs when a special "commit" record is appended to the WAL. (the original database may not be altered!)
- multiple transactions can be committed before a "checkpoint", when the database will be updated according to write-ahead log.
