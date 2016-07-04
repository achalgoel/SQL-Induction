

CREATE TABLE    --Creating table Product master--
	t_product_name
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



