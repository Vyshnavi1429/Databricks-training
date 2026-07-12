# Task 1: Create Gold / Silver / Bronze Segmentation
from pyspark.sql.functions import sum, when, col

result = (
    sales.groupBy("customer_id")
         .agg(sum("total_amount").alias("total_spend"))
         .withColumn(
             "segment",
             when(col("total_spend") > 10000, "Gold")
             .when((col("total_spend") >= 5000) & (col("total_spend") <= 10000), "Silver")
             .otherwise("Bronze")
         )
)

result.show()

# Task 2: Count Customers in Each Segment
result.groupBy("segment").count().show()

# Task 3: Quantile-based Segmentation
quantiles = result.approxQuantile("total_spend", [0.33, 0.66], 0)
print(quantiles)


