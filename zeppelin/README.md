# Getting Started

1. Start Zeppelin:

   ```
   docker run --rm --name=zeppelin -p 8080:8080 -p 8081:8081 \
   -v ~/metrics:/srv/metrics/:ro \
   -d asarkar/zeppelin:0.7.0
   ```
   This exposes the Web UI on port 8080 and mounts host directory `~/metrics` to `/srv/metrics/` in the container.

2. Go to http://localhost:8080 and create a new note. Give it a name.

   > The option may not be available until the circle on the right upper corner turns green.

3. To load a bunch of JSON files, type the following and run it (using the `>` button). This uses a built-in Spark interpreter (the default).

   ```
   val df = spark.read.json("/srv/metrics/*.json")
   df.registerTempTable("metrics")
   ```
   This creates a temp table named `metrics` that you can query. To learn more about Sprak SQL, see [this](http://spark.apache.org/docs/latest/sql-programming-guide.html).

   > 1. Spark will automatically infer the schema. to see the schema, run `df.printSchema()`.
   > 2. To pass arguments to the Scala compiler, for example to view deprecation warnings, go to http://localhost:8080/#/interpreter, click "edit", and add `-deprecation` to the `args` property.
   
4. In another paragraph, start writing queries. For example:

   ```
   %sql select age, count(1) from metrics where age < 30 group by age order by age
   ```
   More examples can be found here: [Zeppelin Tutorial](https://zeppelin.apache.org/docs/0.5.5-incubating/tutorial/tutorial.html)

   The output can be visualized in tabular or one of various graphical formats.

   > Column names with periods in them have to be escaped by enclosing in backticks.
   
   See [zeppelin-learning](https://github.com/asarkar/spark/tree/master/eappelin-learning) project for examples.
