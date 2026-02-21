USE czech_bank;

WITH trans_features AS (
	SELECT
		t.account_id,
        MIN(t.balance) AS min_balance_pre_loan,
        AVG(t.balance) AS avg_balance_pre_loan,
        COUNT(t.trans_id) AS num_transactions_pre_loan,
        SUM(CASE WHEN operation_en = 'cash' THEN 1.0 ELSE 0.0 END) / NULLIF(COUNT(trans_id), 0) AS share_cash_trans
	FROM trans t
    JOIN loan l
    USING (account_id)
    WHERE t.date_clean < l.date_clean
    GROUP BY t.account_id
),
disp_features AS (
	SELECT
		account_id,
        COUNT(disp_id) AS amount_disponents
	FROM disp
    GROUP BY account_id
)

SELECT
    l.amount,
    l.duration,
    l.payments,
    TIMESTAMPDIFF(MONTH, a.date_clean, l.date_clean) AS tenure_at_loan,
    a.frequency_en AS frequency_bank_statements,
    d.inhabitants,
    d.no_cities,
    d.urban_ratio,
    d.avg_salary,
    (d.unemp_1995 + d.unemp_1996) / 2 AS avg_unemp_95_96,
    d.entr_per_1k,
    (d.crimes_1995 + d.crimes_1996) / 2 AS avg_crimes_95_96,
    tf.min_balance_pre_loan,
    tf.avg_balance_pre_loan,
    tf.num_transactions_pre_loan,
    tf.share_cash_trans,
    df.amount_disponents,
    COALESCE(c.type, 'no card') AS card_type_at_loan,
    cl.gender,
    TIMESTAMPDIFF(YEAR, cl.birth_date, l.date_clean) AS age_at_loan,
    l.result
FROM loan l
JOIN account a USING (account_id)
JOIN district d USING (district_id)
JOIN trans_features tf USING (account_id)
JOIN disp_features df USING (account_id)
LEFT JOIN disp di ON l.account_id = di.account_id AND di.type = 'OWNER'
LEFT JOIN card c ON di.disp_id = c.disp_id AND c.issued_clean < l.date_clean
LEFT JOIN client cl ON cl.client_id = di.client_id