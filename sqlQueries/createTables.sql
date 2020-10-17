CREATE TABLE pollutant_type(
    id serial PRIMARY KEY,
    name VARCHAR (255) UNIQUE NOT NULL
);

CREATE TABLE pollutant_sample(
    id serial PRIMARY KEY,
    date_local TIMESTAMP,
    max_hour INT,
    max_value INT,
    aqi INT,
    units VARCHAR (255),
    mean DOUBLE PRECISION
);

CREATE TABLE is_type(
    type_id INT NOT NULL,
    sample_id INT NOT NULL,
    PRIMARY KEY (type_id, sample_id),
    FOREIGN KEY (type_id)
        REFERENCES pollutant_type (id)
        ON UPDATE CASCADE,
    FOREIGN KEY (sample_id)
        REFERENCES pollutant_sample (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE survey_site(
    site_num serial PRIMARY KEY,
    address VARCHAR (255),
    city VARCHAR (255)
);

CREATE TABLE taken_at(
    sample_id INT NOT NULL,
    site_num INT NOT NULL,
    PRIMARY KEY (sample_id, site_num),
    FOREIGN KEY (sample_id)
        REFERENCES pollutant_sample (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (site_num)
        REFERENCES survey_site (site_num)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE county(
    county_code serial PRIMARY KEY,
    county_name VARCHAR (255)
);

CREATE TABLE in_county(
    site_num INT NOT NULL,
    county_code INT NOT NULL,
    PRIMARY KEY (site_num, county_code),
    FOREIGN KEY (site_num)
        REFERENCES survey_site (site_num)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (county_code)
        REFERENCES county (county_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE state(
    state_code serial PRIMARY KEY,
    state_name VARCHAR (255)
);

CREATE TABLE in_state(
    site_num INT NOT NULL,
    state_code INT NOT NULL,
    PRIMARY KEY (site_num, state_code),
    FOREIGN KEY (site_num)
        REFERENCES survey_site (site_num)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (state_code)
        REFERENCES state (state_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


