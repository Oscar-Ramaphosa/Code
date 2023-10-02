// this is for the employee graph
        private void SqlServerConnection()
        {
            string connectionString = @"Data Source=127.0.0.1; Initial Catalog=intellilog2; User ID=sa; Password=ilog123";
            SqlConnection connection = new SqlConnection(connectionString);
            DataSet ds = new DataSet();
            connection.Open();
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TOP 4 employee.firstName, employee.lastName, " +
                                                        "Sum(access_log.bytes) AS SumOfbytes\r\nFROM access_log INNER JOIN employee ON " +
                                                        "access_log.remotehost = employee.ipAdress\r\nGROUP BY employee.firstName," +
                                                        " employee.lastName, access_log.remotehost ORDER BY Sum(access_log.bytes);", connection);
            adapter.Fill(ds);
            chart1.DataSource = ds;
            chart1.Series["Usage"].XValueMember = "firstName";
            chart1.Series["Usage"].YValueMembers = "SumOfbytes";
            chart1.Titles.Add("Employee Usage");
            connection.Close();

        }

        //this is for the web sites usage graph
        private void WebUsageSQLConnection()
        {
            string connectionString = @"Data Source=127.0.0.1; Initial Catalog=intellilog2; User ID=sa; Password=ilog123";
            SqlConnection connection = new SqlConnection(connectionString);
            DataSet ds = new DataSet();
            connection.Open();
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT TOP 7 access_log.domain, Sum(access_log.bytes)" +
                                                        "AS SumOfbytes\r\nFROM access_log\r\nGROUP BY " +
                                                        "access_log.domain ORDER BY Sum(access_log.bytes);\r\n", connection);
            adapter.Fill(ds);
            chart2.DataSource = ds;
            chart2.Series["WebUsage"].XValueMember = "domain";
            chart2.Series["WebUsage"].YValueMembers = "SumOFbytes";
            chart2.Titles.Add("Websites Usage");
            connection.Close();

        }

private void Form1_Load(object sender, EventArgs e)
        {
            SqlServerConnection();
            WebUsageSQLConnection();
            fillListBox();
            showOnSitesGrid();
            showPermissionGrid();
            showOnSitesGroupGrid();
            showOnUserGroupGrid();
            showOnGroupsGrid();
        }

