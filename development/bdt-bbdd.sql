CREATE TABLE  RESUME (
  resume_id INT NOT NULL,
  resume_url VARCHAR(45) NOT NULL,
  PRIMARY KEY (resume_id)
);

CREATE TABLE  EDUCATION (
  education_id INT NOT NULL,
  education_level VARCHAR(150) NOT NULL,
  education_title VARCHAR(45) NOT NULL,
  PRIMARY KEY (education_id)
);

CREATE TABLE  POSITION (
  position_id INT NOT NULL,
  position_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (position_id)
);

CREATE TABLE  STATE (
  state_id INT NOT NULL,
  state_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (state_id)
);

CREATE TABLE  CITY (
  city_id INT NOT NULL,
  city_name VARCHAR(45) NOT NULL,
  state_id INT NOT NULL,
  PRIMARY KEY (city_id),
  CONSTRAINT STATE
    FOREIGN KEY (state_id)
    REFERENCES STATE (state_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE  USER (
  user_id INT NOT NULL,
  user_name VARCHAR(45) NOT NULL,
  user_lastname VARCHAR(45) NOT NULL,
  user_age VARCHAR(3) NOT NULL,
  user_phone VARCHAR(15) NOT NULL,
  user_email VARCHAR(45) NOT NULL,
  user_avatar VARCHAR(45) NOT NULL,
  resume_id INT NOT NULL,
  education_id INT NOT NULL,
  position_id INT NOT NULL,
  city_id INT NOT NULL,
  PRIMARY KEY (user_id),
  CONSTRAINT RESUME
    FOREIGN KEY (resume_id)
    REFERENCES RESUME (resume_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT EDUCATION
    FOREIGN KEY (education_id)
    REFERENCES EDUCATION (education_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT POSITION
    FOREIGN KEY (position_id)
    REFERENCES POSITION (position_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT CITY
    FOREIGN KEY (city_id)
    REFERENCES CITY (city_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE  COMPANY (
  company_id INT NOT NULL,
  company_name VARCHAR(45) NOT NULL,
  company_email VARCHAR(45) NOT NULL,
  company_thumbnail VARCHAR(45) NOT NULL,
  city_id INT NOT NULL,
  PRIMARY KEY (company_id),
  CONSTRAINT CITY2
    FOREIGN KEY (city_id)
    REFERENCES CITY (city_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTON
);

CREATE TABLE  FAV (
  resume_id INT NOT NULL,
  company_id INT NOT NULL,
  CONSTRAINT RESUME2
    FOREIGN KEY (resume_id)
    REFERENCES RESUME (resume_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT COMPANY
    FOREIGN KEY (company_id)
    REFERENCES COMPANY (company_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE  EXPERIENCE (
  experience_id INT NOT NULL,
  experience_name VARCHAR(45) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  description TEXT(150) NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (experience_id),
  CONSTRAINT USER
    FOREIGN KEY (user_id)
    REFERENCES USER (user_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);I
