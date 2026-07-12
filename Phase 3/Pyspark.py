# 1. Read sales data -> clean nulls -> calculate daily sales
from pyspark.sql.functions import sum

sales = spark.read.csv("/samples/sales.csv", header=True, inferSchema=True)

sales = sales.dropna()

daily_sales = (
    sales.groupBy("sale_date")
         .agg(sum("total_amount").alias("daily_sales"))
)

daily_sales.show()

# 2. Read customer data -> clean invalid rows -> city-wise revenue
from pyspark.sql.functions import sum

# Read data
customers = spark.read.csv("/samples/customers.csv", header=True, inferSchema=True)
sales = spark.read.csv("/samples/sales.csv", header=True, inferSchema=True)

# Remove invalid rows (null customer_id or city)
customers = customers.dropna(subset=["customer_id", "city"])
sales = sales.dropna(subset=["customer_id", "total_amount"])

# City-wise revenue
result = (
    customers.join(sales, "customer_id")
             .groupBy("city")
             .agg(sum("total_amount").alias("total_revenue"))
             .orderBy("city")
)

result.show()


# 3. Find repeat customers (>2 orders)
from pyspark.sql.functions import count, col

result = (
    sales.groupBy("customer_id")
         .agg(count("*").alias("total_orders"))
         .filter(col("total_orders") > 2)
)

result.show()


# 4. Find highest spending customer in each city
from pyspark.sql.functions import sum, col
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number

# Total spend per customer in each city
customer_spend = (
    sales.join(customers, "customer_id")
         .groupBy("city", "customer_id")
         .agg(sum("total_amount").alias("total_spend"))
)

# Find highest spender in each city
window_spec = Window.partitionBy("city").orderBy(col("total_spend").desc())

result = (
    customer_spend.withColumn("rank", row_number().over(window_spec))
                  .filter(col("rank") == 1)
                  .drop("rank")
)

result.show()

# 5. Build final reporting table with customer, city, total spend, order count
from pyspark.sql.functions import sum, count

result = (
    sales.join(customers, "customer_id")
         .groupBy("customer_id", "first_name", "last_name", "city")
         .agg(
             sum("total_amount").alias("total_spend"),
             count("*").alias("order_count")
         )
)

result.show()



