# ClickHouse UDF Update Test

Simple repo to show that ClickHouse UDFs does not seem to support UPDATEs

See https://github.com/ClickHouse/ClickHouse/issues/77750

## Quick start

```bash
docker compose up -d
docker compose exec ch01 clickhouse client --user admin --password pass4admin
```

Check to make sure UDF is working

```
SELECT test_function_cpp('test')

   ┌─test_function_cpp('test')─┐
1. │ Key test                  │
   └───────────────────────────┘
```

Create a ReplicatedMergeTree table and insert values

```
CREATE TABLE udf_test
(
    `id` UInt64,
    `value` String
)
ENGINE = ReplicatedMergeTree
ORDER BY id;

INSERT INTO udf_test VALUES (1,'a'),(2,'b'),(3,'c');

SELECT *
FROM udf_test;

Query id: 24e9b57f-7956-4997-bd06-a352ce33235b

   ┌─id─┬─value─┐
1. │  1 │ a     │
2. │  2 │ b     │
3. │  3 │ c     │
   └────┴───────┘
```

Test UDF on simple select

```
SELECT test_function_cpp(value)
FROM udf_test;

   ┌─test_function_cpp(value)─┐
1. │ Key a                    │
2. │ Key b                    │
3. │ Key c                    │
   └──────────────────────────┘
```

Update table values based on select

```
ALTER TABLE udf_test
    (UPDATE value = test_function_cpp(value) WHERE 1 = 1)

Received exception from server (version 25.12.2):
Code: 46. DB::Exception: Received from localhost:9000. DB::Exception: Unknown function test_function_cpp: While processing test_function_cpp(value). (UNKNOWN_FUNCTION)
```
