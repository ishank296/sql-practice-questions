sql-practice


<h2>SQL WINDOW WITH ROWS BETWEEN</h2>

Window function allow sliding window frames

<ul>Code</ul>
SELECT <column_1>, <column_2>,
  OVER (
    PARTITION BY <...>
    ORDER BY <...>
        <window_frame>) <window_column_alias>
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
