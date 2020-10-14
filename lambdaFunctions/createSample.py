import sys
import logging
import rds_config
import pymysql
#rds settings
rds_host  = "rds-instance-endpoint"
name = rds_config.db_username
password = rds_config.db_password
db_name = rds_config.db_name

logger = logging.getLogger()
logger.setLevel(logging.INFO)

try:
    conn = psycopg2.connect(dbname=suppliers, 
                            user=postgres, 
                            password=postgres)
except pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)
    sys.exit()

logger.info("SUCCESS: Connection to RDS MySQL instance succeeded")
def handler(event, context):
    """
    This function inserts a sample into the database
    """

    item_count = 0

    date = event['date_local']
    maxhour = event['max_hour']
    aqi = event['aqi']
    units = event['units']
    mean = event['mean']
    site = event['site']
    ptype = event['pid']
    psInsert = f'INSERT INTO pollutant_sample VALUES (DEFAULT, {date}, {maxhour}, {aqi}, {units}, {mean}) RETURNING id


    with conn.cursor() as cur:
        cur.execute(psInsert)
        genId = cur.fetchone()
        conn.commit()
        typeInsert = f'INSERT INTO is_type VALUES ({ptype}, {genId})'
        siteInsert = f'INSERT INTO taken_at VALUES ({genId}, {site})'
        cur.execute(typeInsert)
        cur.execute(siteInsert)
    conn.commit()

    return f"Successfully inserted sample id: {genId}"