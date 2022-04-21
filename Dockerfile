FROM --platform=linux/amd64 python:3.9.10-buster

# Install pyodbc dependencies
RUN apt-get update
RUN apt-get install -y build-essential libssl-dev libffi-dev python3-dev tdsodbc g++ unixodbc-dev
RUN apt install unixodbc-bin -y
RUN apt install unixodbc-dev -y
RUN apt-get clean -y
ADD odbcinst.ini /etc/odbcinst.ini

# Install the Microsoft ODBC driver for SQL Server (Linux)
# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15
RUN apt-get update
RUN apt-get install apt-transport-https 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Add path
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile 
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc 

# Install pyodbc
RUN pip3 install --upgrade pip
COPY requirements.txt .
RUN pip3 install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt
