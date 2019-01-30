---
layout: docs-cn
title:  "SQL 函数"
categories: tutorial
permalink: /cn/docs/tutorial/kylin_function.html
---

## 函数

[COUNT](#COUNT)
　[COUNT(COLUMN)](#COUNT_COLUMN)
　[COUNT(*)](#COUNT_)
[COUNT_DISTINCT](#COUNT_DISTINCT)
[MAX](#MAX)
[MIN](#MIN)
[PERCENTILE](#PERCENTILE)
[SUM](#SUM)
[TOP_N](#TOP_N)

[WINDOW](#WINDOW)
　[ROW_NUMBER](#ROW_NUMBER)
　[AVG](#AVG)
　[RANK](#RANK)
　[DENSE_RANK](#DENSE_RANK)
　[FIRST_VALUE](#FIRST_VALUE)
　[LAST_VALUE](#LAST_VALUE)
　[LAG](#LAG)
　[LEAD](#LEAD)
　[NTILE](#NTILE)
　[CASE WHEN](#CASEWHEN)
　[CAST](#CAST)

[SUSTRING](#SUBSTRING)
[COALESCE](#COALESCE)


## COUNT {#COUNT}
用于返回与指定条件匹配的行数。

### COUNT(COLUMN) {#COUNT_COLUMN}

例子：
{% highlight Groff markup %}
SELECT COUNT(seller_id) FROM kylin_sales;
{% endhighlight %}

### COUNT(*) {#COUNT_}

例子：
{% highlight Groff markup %}
SELECT COUNT(*) FROM kylin_sales;
{% endhighlight %}


## COUNT_DISTINCT {#COUNT_DISTINCT}

例子：
{% highlight Groff markup %}
SELECT COUNT(DISTINCT seller_id) AS DIST_SELLER FROM kylin_sales;
{% endhighlight %}

## MAX {#MAX}
返回一列中的最大值。NULL 值不包括在计算中。
例子：
{% highlight Groff markup %}
SELECT MAX(lstg_site_id) FROM kylin_sales;
{% endhighlight %}


## MIN {#MIN}
返回一列中的最小值。NULL 值不包括在计算中。
例子：
{% highlight Groff markup %}
SELECT MIN(lstg_site_id) FROM kylin_sales;
{% endhighlight %}


## PERCENTILE {#PERCENTILE}

例子：
{% highlight Groff markup %}
SELECT seller_id, PERCENTILE(price, 0.5) FROM kylin_sales GROUP BY seller_id;

SELECT seller_id, PERCENTILE_APPROX(price, 0.5) FROM kylin_sales GROUP BY seller_id;
{% endhighlight %}


## SUM {#SUM}
返回数值列的总数。
例子：
{% highlight Groff markup %}
SELECT SUM(price) FROM kylin_sales;
{% endhighlight %}

## TOP_N {#TOP_N}

例子：
{% highlight Groff markup %}
SELECT SUM(price) AS gmv
 FROM kylin_sales 
INNER JOIN kylin_cal_dt AS kylin_cal_dt
 ON kylin_sales.part_dt = kylin_cal_dt.cal_dt
 INNER JOIN kylin_category_groupings
 ON kylin_sales.leaf_categ_id = kylin_category_groupings.leaf_categ_id AND kylin_sales.lstg_site_id = kylin_category_groupings.site_id
 WHERE kylin_cal_dt.cal_dt between DATE '2013-09-01' AND DATE '2013-10-01' AND (lstg_format_name='FP-GTC' OR 'a' = 'b')
 GROUP BY kylin_cal_dt.cal_dt;
 
SELECT kylin_sales.part_dt, seller_id
FROM kylin_sales
INNER JOIN kylin_cal_dt AS kylin_cal_dt
ON kylin_sales.part_dt = kylin_cal_dt.cal_dt
INNER JOIN kylin_category_groupings
ON kylin_sales.leaf_categ_id = kylin_category_groupings.leaf_categ_id
AND kylin_sales.lstg_site_id = kylin_category_groupings.site_id 
GROUP BY 
kylin_sales.part_dt, kylin_sales.seller_id ORDER BY SUM(kylin_sales.price) DESC LIMIT 20;
{% endhighlight %}

## WINDOW {#WINDOW}
```WINDOW``` 函数在和当前行相关的一组表行上执行计算。
*注意*：```WINDOW``` 函数中必须有 ```OVER``` 子句

### ROW_NUMBER {#ROW_NUMBER}

例子：
{% highlight Groff markup %}
SELECT lstg_format_name, SUM(price) AS gmv, ROW_NUMBER() OVER() FROM kylin_sales GROUP BY lstg_format_name;
{% endhighlight %}

### AVG {#AVG}
返回数值列的平均值。NULL 值不包括在计算中。
例子：
{% highlight Groff markup %}
SELECT lstg_format_name, AVG(SUM(price)) OVER(PARTITION BY lstg_format_name) FROM kylin_sales GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### RANK {#RANK}

例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price), RANK() OVER(PARTITION BY lstg_format_name ORDER BY part_dt) AS "rank" FROM kylin_sales GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### DENSE_RANK {#DENSE_RANK}

例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price), DENSE_RANK() OVER(PARTITION BY lstg_format_name ORDER BY part_dt) AS "dense_rank" FROM kylin_sales GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### FIRST_VALUE {#FIRST_VALUE}

例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price) AS gmv, FIRST_VALUE(SUM(price)) OVER(PARTITION BY lstg_format_name ORDER BY part_dt) AS "first" FROM kylin_sales WHERE part_dt < '2012-02-01' GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### LAST_VALUE {#LAST_VALUE}

例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price) AS gmv, LAST_VALUE(SUM(price)) OVER(PARTITION BY lstg_format_name ORDER BY part_dt) AS "current" FROM kylin_sales WHERE part_dt < '2012-02-01' GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### LAG {#LAG}

例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price) AS gmv, LAG(SUM(price), 1, 0.0) OVER(PARTITION BY lstg_format_name ORDER BY part_dt) AS "prev" FROM kylin_sales WHERE part_dt < '2012-02-01' GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### LEAD {#LEAD}

例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price) AS gmv, LEAD(SUM(price), 1, 0.0) OVER(PARTITION BY lstg_format_name ORDER BY part_dt) AS "next" FROM kylin_sales WHERE part_dt < '2012-02-01' GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### NTILE {#NTILE}

例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price) AS gmv, NTILE(4) OVER (PARTITION BY lstg_format_name ORDER BY part_dt) AS "quarter" FROM kylin_sales WHERE part_dt < '2012-02-01' GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### CASE WHEN {#CASEWHEN}

例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price) AS gmv, (CASE LAG(SUM(price), 1, 0.0) OVER(PARTITION BY lstg_format_name ORDER BY part_dt) WHEN 0.0 THEN 0 ELSE SUM(price)/LAG(SUM(price), 1, 0.0) OVER(PARTITION BY lstg_format_name ORDER BY part_dt) END) AS "prev" FROM kylin_sales WHERE part_dt < '2012-02-01' GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

### CAST {#CAST}
```RANGE```，```INTERVAL``` 关键字指明了范围。```PRECEDING``` 表示前几天（秒/分/时/月/年）。```FOLLOWING``` 表示后几天（秒/分/时/月/年）。
例子：
{% highlight Groff markup %}
SELECT part_dt, lstg_format_name, SUM(price) AS gmv, FIRST_VALUE(SUM(price)) OVER (PARTITION BY lstg_format_name ORDER BY CAST(part_dt AS timestamp) RANGE INTERVAL '3' DAY PRECEDING) AS "prev 3 days", LAST_VALUE(SUM(price)) OVER (PARTITION BY lstg_format_name ORDER BY CAST(part_dt AS timestamp) RANGE INTERVAL '3' DAY FOLLOWING) AS "next 3 days" FROM kylin_sales WHERE part_dt < '2012-02-01' GROUP BY part_dt, lstg_format_name;
{% endhighlight %}

## SUBSTRING {#SUBSTRING}
例子：
{% highlight Groff markup %}
SELECT SUBSTRING(lstg_format_name, 1) FROM kylin_sales;
{% endhighlight %}
	
## COALESCE {#COALESCE}
例子：
{% highlight Groff markup %}
SELECT COALESCE(lstg_format_name, '888888888888') FROM kylin_sales;
{% endhighlight %}
