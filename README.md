# python-docker-for-pyodbc-sqlserver

https://hub.docker.com/r/cymagix/python-for-pyodbc-sqlserver

Docker image to deploy apps on Python 3.9.10, using pyodbc 4.0.32 and ODBC Driver 17 for MS SQL Server®.

## Elements

Uses official image [Python 3.9.10-buster](https://hub.docker.com/_/python/)

- Debian 10.0 (Buster)
- Python 3.9.10
- [Pyodbc 4.0.32](https://pypi.org/project/pyodbc/4.0.32/)
- [Microsoft® ODBC SQL Server® 17 Driver](https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16#version-17)

## Usage

Example of usage for Dockerfile of FastAPI app:

```Dockerfile
FROM masaiborg/python-for-pyodbc-msodbcsql

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

EXPOSE 8000
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]

```

Also, in your Python code, connect as follows:

```python
import pyodbc

def init_connection():
    config = ('Driver={ODBC Driver 17 for SQL Server};' +
                'Server=127.0.0.1,1433;' +
                'Database=yourdb;' +
                'UID=SA;' +
                'PWD=your@password;')
    connection = pyodbc.connect(config)
    return connection.cursor()
```

### License

See this [License](LICENSE)

### Trademark Notices

Microsoft® and SQL Server® are registered trademarks of Microsoft Corporation.

