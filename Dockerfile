FROM apache/airflow:2.10.0-python3.12
ENV AIRFLOW_HOME=/usr/local/airflow
USER root
## permisos airflow y docker
RUN usermod -u 1003 airflow
RUN groupadd -g 994 docker
RUN usermod -G docker airflow
RUN apt-get update && apt-get install -y \
    python3-pip=23.0.1+dfsg-1 \
    libcurl4-gnutls-dev=7.88.1-10+deb12u6 \
    python3-dev=3.11.2-1+b1 \
    libpq-dev=16.4-1.pgdg120+1 \
    default-libmysqlclient-dev=1.1.0 \
    default-mysql-client=1.1.0 \
    && apt-get clean;
USER airflow
RUN pip install --no-cache-dir pymssql==2.3.0 PyGreSQL==6.0.1 pycurl==7.45.3 apache-airflow-providers-microsoft-mssql==3.9.0 mysql-connector-python==8.3.0 mysqlclient==2.2.4 pandas==2.2.2 SQLAlchemy==1.4.52 apache-airflow-providers-docker==3.13.0 apache-airflow-providers-ssh==3.13.0 dicttoxml==1.7.16 XlsxWriter==3.2.0 apache-airflow-providers-http==4.13.0 apache-airflow-providers-slack==8.9.0 filesplit==4.0.1 shortuuid==1.0.13 openpyxl==3.1.5
USER root
COPY ./config/* ${AIRFLOW_HOME}/config/
RUN mkdir -p ${AIRFLOW_HOME}/logs ${AIRFLOW_HOME}/plugins ${AIRFLOW_HOME}/dags
RUN chown -R airflow: ${AIRFLOW_HOME}/{logs,dags,plugins}
RUN chown -R airflow: ${AIRFLOW_HOME}
USER airflow
WORKDIR ${AIRFLOW_HOME}