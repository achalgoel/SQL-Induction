

CREATE TABLE    --Creating table Product master--
	t_product_master
	(
	Product_ID varchar(3) PRIMARY KEY,
	Product_Name varchar(30),
	Cost_Per_Item int 
	);

CREATE TABLE     --Creating table User master--
	t_user_master
		(
		Users_ID varchar(3) PRIMARY KEY,
		Users_Name varchar(30)
		);

CREATE TABLE           --Creating table transaction--
	t_transaction
		(
		Users_ID varchar(3),
		Product_ID varchar(3),
		Transaction_Date date,
		Transaction_Type varchar(20),
		Transaction_Amount int
		);

						
						
				      --TEMPORARY TABLES--




				 --Temp table  #t_amount_paid

SELECT                             
	t_transaction.Users_ID,
	t_transaction.Product_ID,
	SUM(t_transaction.Transaction_Amount)
	AS
		AmountPaid
INTO
	 #t_amount_paid
FROM
	t_transaction
WHERE
	Transaction_Type='Payment'
GROUP BY
	t_transaction.Users_ID,
	t_transaction.Product_ID;

SELECT *
FROM #t_amount_paid;



                             --Temp table  #t_Order

SELECT                             
	t_transaction.Users_ID,
	t_transaction.Product_ID,
	SUM(t_transaction.Transaction_Amount)
	AS
		OrderAmount
INTO
	 #t_order
FROM
	t_transaction
WHERE
	Transaction_Type='Order'
GROUP BY
	t_transaction.Users_ID,
	t_transaction.Product_ID;

SELECT *
FROM #t_order


                         --Temp table  #t_total_amount 

SELECT
	#t_order.Users_ID,
	#t_order.Product_ID,
	SUM(#t_order.OrderAmount * t_product_master.Cost_Per_Item )
		AS
		TotalAmount
INTO
	#t_total_amount
FROM
	#t_order,
	t_product_master
WHERE
	#t_order.Product_ID=t_product_master.Product_ID
	
GROUP BY
	#t_order.Users_ID,
	#t_order.Product_ID

SELECT *
FROM #t_total_amount


                        --Temp table  #t_balance (Total Amount - Amount Paid)
SELECT
	#t_total_amount.Users_ID,
	#t_total_amount.Product_ID,
	#t_total_amount.TotalAmount
	-
	ISNULL(#t_amount_paid.AmountPaid,0)
	AS
		Balance
INTO
	#t_balance
FROM
	#t_total_amount
LEFT JOIN
	#t_amount_paid
ON
	#t_total_amount.Users_ID=#t_amount_paid.Users_ID
	AND
	#t_total_amount.Product_ID=#t_amount_paid.Product_ID

SELECT *
FROM #t_balance


	               -- Temp table last transaction date

SELECT	                
	t_transaction.Users_ID,
	t_transaction.Product_ID,
	MAX(t_transaction.Transaction_Date)
	AS
		LastTransactionDate
INTO 
	#t_last_transaction_date
FROM
	t_transaction
GROUP BY
	Users_ID,
	Product_ID;



	
	
	                        --Main query
	SELECT
		t_user_master.Users_Name,
		T1111.Product_Name,
		T1111.OrderedQuantity,
		T1111.AmountPaid,
		T1111.LastTransactionDate,
		T1111.Balance
	FROM	
		(
		--T1111 START
			SELECT
				T111.Users_ID,
				T111.Product_Name,
				T111.Product_ID,
				T111.OrderedQuantity,
				T111.AmountPaid,
				T111.LastTransactionDate,
				#t_balance.Balance

			FROM
				(
			--T111 START
				SELECT
					T11.Users_ID,
					T11.Product_ID,
					T11.Product_Name,
					T11.OrderedQuantity,
					AmountPaid,
					#t_last_transaction_date.LastTransactionDate
					 	
				FROM
						(
					--T11 START
						SELECT
							T1.Users_ID,
							T1.Product_Name,
							T1.Product_ID,
							T1.OrderedQuantity,
							 ISNULL(#t_amount_paid.AmountPaid,0)
							 AS
								AmountPaid
						FROM
								(
						--T1 START
								SELECT               
									t_transaction.Users_ID,
									t_transaction.Product_ID,
									t_product_master.Product_Name,
									SUM(
									t_transaction.Transaction_Amount
										)
									AS
										OrderedQuantity
								FROM 
									t_transaction
								INNER JOIN
									t_product_master
								ON
										t_transaction.Product_ID = t_product_master.Product_ID
								WHERE
									t_transaction.Transaction_Type='Order' 
								GROUP BY
									t_product_master.Product_Name,
									t_transaction.Users_ID,
									t_transaction.Product_ID
						--T1 END
								)
								AS 
									T1
						LEFT JOIN
							 #t_amount_paid
						ON
							 #t_amount_paid.Users_ID = T1.Users_ID
							 AND
							 T1.Product_ID = #t_amount_paid.Product_ID
						
				   --T11 END
						)
						AS
							T11	
						INNER JOIN
							#t_last_transaction_date
						ON
						#t_last_transaction_date.Users_ID = T11.Users_ID
						AND
						#t_last_transaction_date.Product_ID = T11.Product_ID
				--T111 END			
				)
				AS
					T111
				INNER JOIN
				#t_balance
				ON
				#t_balance.Users_ID = T111.Users_ID
				AND
				#t_balance.Product_ID=T111.Product_ID
			--T1111 END
			)
		AS
			T1111
		RIGHT JOIN
			t_user_master
		ON
			t_user_master.Users_ID=T1111.Users_ID;
