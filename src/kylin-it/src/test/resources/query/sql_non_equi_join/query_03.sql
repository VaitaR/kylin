-- Licensed to the Apache Software Foundation (ASF) under one or more
-- contributor license agreements.  See the NOTICE file distributed with
-- this work for additional information regarding copyright ownership.
-- The ASF licenses this file to You under the Apache License, Version 2.0
-- (the "License"); you may not use this file except in compliance with
-- the License.  You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
SELECT COUNT(1), TEST_KYLIN_FACT.SELLER_ID, TEST_ACCOUNT.ACCOUNT_ID, sum(TEST_KYLIN_FACT.ITEM_COUNT), count(TEST_ACCOUNT.ACCOUNT_CONTACT)
FROM TEST_KYLIN_FACT
LEFT JOIN TEST_ACCOUNT
ON
TEST_KYLIN_FACT.SELLER_ID = TEST_ACCOUNT.ACCOUNT_ID
OR TEST_KYLIN_FACT.LSTG_FORMAT_NAME='FP-GTC'
AND
(TEST_KYLIN_FACT.SELLER_ID <> TEST_ACCOUNT.ACCOUNT_ID)
AND (
TEST_KYLIN_FACT.PRICE > 100
AND (
TEST_KYLIN_FACT.ITEM_COUNT < 10
OR (NOT
TEST_KYLIN_FACT.PRICE * TEST_KYLIN_FACT.ITEM_COUNT > 500
)))
AND (not (not TEST_KYLIN_FACT.ITEM_COUNT < 10))
group by TEST_KYLIN_FACT.SELLER_ID, TEST_ACCOUNT.ACCOUNT_ID
order by 1,2,3,4,5
limit 10000