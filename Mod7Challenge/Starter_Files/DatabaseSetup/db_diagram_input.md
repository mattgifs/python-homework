
merchant_category
-
id_merchant_category PK INT
merchant_category_name VARCHAR(20)

merchant
-
id_merchant PK INT
merchant_name VARCHAR(60)
id_merchant_category INT FK >- merchant_category.id_merchant_category

transaction
-
transaction_id PK INT
transaction_date TIMESTAMP
amount FLOAT
card_number VARCHAR(20) FK >- credit_card.card_number
id_merchant INT FK >- merchant.id_merchant

card_holder
-
cardholder_id PK INT
cardholder_name VARCHAR(60)

credit_card
-
card_number PK VARCHAR(20)
cardholder_id INT FK >- card_holder.cardholder_id





