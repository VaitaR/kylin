--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
SELECT {fn CONVERT({fn TRUNCATE((6 + {fn DAYOFYEAR("CALCS"."DATETIME0")} + ({fn MOD((7 + {fn DAYOFWEEK({fn TIMESTAMPADD(SQL_TSI_DAY,{fn CONVERT({fn TRUNCATE((-1 * ({fn DAYOFYEAR("CALCS"."DATETIME0")} - 1)),0)}, SQL_BIGINT)},{fn CONVERT("CALCS"."DATETIME0", SQL_DATE)})})} - 2 ), 7)})) / 7,0)}, SQL_BIGINT)} AS "TEMP_Test__2850144041__1_"
FROM "TDVT"."CALCS" "CALCS"
GROUP BY {fn CONVERT({fn TRUNCATE((6 + {fn DAYOFYEAR("CALCS"."DATETIME0")} + ({fn MOD((7 + {fn DAYOFWEEK({fn TIMESTAMPADD(SQL_TSI_DAY,{fn CONVERT({fn TRUNCATE((-1 * ({fn DAYOFYEAR("CALCS"."DATETIME0")} - 1)),0)}, SQL_BIGINT)},{fn CONVERT("CALCS"."DATETIME0", SQL_DATE)})})} - 2 ), 7)})) / 7,0)}, SQL_BIGINT)}