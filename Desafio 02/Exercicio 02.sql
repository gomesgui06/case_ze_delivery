-- Consulta 01: Retornar a evolução da quantidade em estoque por categoria de produto por data;
SELECT 
	DateID.YearMonth,
	ProductID.ProductCategory,
	sum(DailyInventory.StockQuantity)

FROM DailyInventory
	JOIN Date ON Date.DateID = DailyInventory.DateID
	JOIN Product ON Product.ProductID = DailyInventory.ProductID

GROUP BY
	Date.YearMonth, Product.ProductCategory

ORDER BY 
	Date.YearMonth, Product.ProductCategory ASC;


-- CONSULTA 02: Retornar a posição de estoque mais recente da quantidade de produtos por categoria;
SELECT 
	t1.YearMonth,
	ProductID.ProductCategory,
	sum(DailyInventory.StockQuantity)

FROM DailyInventory
	JOIN (SELECT 
			Date.DateID, 
			FIRST_VALUE(Date.YearMonth) OVER (ORDER BY Date.YearMonth ASC) AS YearMonth
		  FROM  
		  	Date 
		  GROUP BY 
		  	Date.DateID) AS t1
		ON t1.DateID = DailyInventory.DateID
	
	JOIN Product ON Product.ProductID = DailyInventory.ProductID

GROUP BY
	t1.YearMonth, Product.ProductCategory

ORDER BY 
	t1.YearMonth, DailyInventory.DateID ASC;




-- CONSULTA 03: Retornar a quantidade de produtos distintos que já foram armazenados em cada estado;
SELECT 
	WarehouseLocation.State,
	count(DISTINCT Product.ProductName)
FROM DailyInventory
	JOIN WarehouseLocation ON WarehouseLocation.WarehouseID = DailyInventory.WarehouseID
	JOIN Product ON Product.ProductID = DailyInventory.ProductID

GROUP BY 
	WarehouseLocation.State
