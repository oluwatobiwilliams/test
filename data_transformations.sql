CREATE VIEW sera.sales AS (
	SELECT reference,
		TO_TIMESTAMP(transaction_date, 'Mon DDth, YYYY HH:MI:SS AM'::text) AS datetime,
		user_id,
		amount,
		gateway_response,
		transaction_id,
		card_type,
			CASE
				WHEN card_type LIKE 'visa%'::text THEN 'visa'::text
				WHEN card_type LIKE 'mastercard%'::text THEN 'mastercard'::text
				WHEN card_type LIKE 'verve%'::text THEN 'verve'::text
				ELSE card_type
			END AS card_type_group,
			CASE
				WHEN lower(card_type) LIKE '%credit%'::text THEN 'credit'::text
				WHEN lower(card_type) LIKE '%debit%'::text THEN 'debit'::text
				ELSE 'other'::text
			END AS credit_or_debit,
		card_bank,
		country_code,
		currency,
		source,
		status,
		channel
	   FROM sera.sales_txn
);