""" Starter Code with Sample Files
customers = spark.read.option("header", "true").csv("/samples/customers.csv")
orders = spark.read.option("header", "true").csv("/samples/orders.csv")
customers.show()
orders.show()
customers.printSchema()
orders.printSchema()
Mini Cleaning Task
Before solving the exercises, remove rows with missing customer_id from both datasets.
customers = customers.dropna(subset=["customer_id"])
orders = orders.dropna(subset=["customer_id"]) """

# 1. Total order amount for each customer
amount=orders.groupBy("customer_id").sum("total_amount")
amount.show()

# 2. Top 3 customers by total spend
from pyspark.sql.functions import sum, col
max=(orders.groupBy("customer_id").agg(sum("total_amount").alias("total_amount")).orderBy(col("total_amount").desc()))
max.show(3)

# 3. Customers with no orders
result=customers.join(orders,on="customer_id",how="left_anti")
result.show()

# 4. City-wise total revenue
v=orders.join(customers,"customer_id").groupBy("city").agg(sum("total_amount").alias("total_amount"))
v.show(5);

# 5. Average order amount per customer
re=orders.groupBy("customer_id").avg("total_amount")
re.show()

# 6. Customers with more than one order
from pyspark.sql.functions import count, col
result = (
    orders.groupBy("customer_id")
          .agg(count("*").alias("total_orders"))
          .filter(col("total_orders") > 1)
)
result.show()

# 7. Sort customers by total spend descending
from pyspark.sql.functions import sum, col
result = (
    orders.groupBy("customer_id")
          .agg(sum("total_amount").alias("total_spend"))
          .orderBy(col("total_spend").desc())
)
result.show()






