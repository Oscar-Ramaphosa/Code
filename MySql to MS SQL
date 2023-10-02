
        //A function that gets the data from mySql table.
        private DataTable GetDataTableFromMySQL()
        {
            var connection = GetMySQLConnection();
            string query = "SELECT * FROM access_log_1 WHERE id > " + GetLastID().ToString();
            var command = new MySqlCommand(query, connection);
            connection.Open();
            var reader = command.ExecuteReader();
            DataTable table = new DataTable();
            table.Load(reader);
            connection.Close();
            return table;
        }

        //this function get the last id on the table
        private int GetLastID()
        {
            var connection = GetSqlServerConnection();
            connection.Open();
            string query = "SELECT TOP 1 id FROM access_log ORDER BY id DESC;";
            SqlCommand command = new SqlCommand(query, connection);
            int count = Convert.ToInt32(command.ExecuteScalar());
            return count;
        }

        //the function that add data to microsoft Sql
        private void AddToMsSQL(DataTable table)
        {
            var connection = GetSqlServerConnection();
            connection.Open();
            string query = "INSERT INTO access_log (id, time, elapsed,remotehost, result_code, status_code, bytes, request_method, url, domain, ident, hierarchy_code, " +
                                                     "hostname, type1, type2) VALUES (@id, @time, @elapsed,@remotehost, @result_code, @status_code, @bytes, @request_method, @url, @domain, @ident, " +
                                                     "@hierarchy_code, @hostname, @type1, @type2);";

            foreach (DataRow row in table.Rows)
            {

                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.Add(new SqlParameter("@id", SqlDbType.Int) { Value = row["id"] });
                command.Parameters.Add(new SqlParameter("@time", SqlDbType.Int) { Value = row["time"] });
                command.Parameters.Add(new SqlParameter("@elapsed", SqlDbType.Int) { Value = row["elapsed"] });
                command.Parameters.Add(new SqlParameter("@remotehost", SqlDbType.VarChar) { Value = row["remotehost"] });
                command.Parameters.Add(new SqlParameter("@result_code", SqlDbType.VarChar) { Value = row["result_code"] });
                command.Parameters.Add(new SqlParameter("@status_code", SqlDbType.Int) { Value = row["status_code"] });
                command.Parameters.Add(new SqlParameter("@bytes", SqlDbType.Int) { Value = row["bytes"] });
                command.Parameters.Add(new SqlParameter("@request_method", SqlDbType.VarChar) { Value = row["request_method"] });
                command.Parameters.Add(new SqlParameter("@url", SqlDbType.VarChar) { Value = row["url"] });
                command.Parameters.Add(new SqlParameter("@domain", SqlDbType.VarChar) { Value = row["domain"] });
                command.Parameters.Add(new SqlParameter("@ident", SqlDbType.Int) { Value = row["ident"] });
                command.Parameters.Add(new SqlParameter("@hierarchy_code", SqlDbType.VarChar) { Value = row["hierarchy_code"] });
                command.Parameters.Add(new SqlParameter("@hostname", SqlDbType.VarChar) { Value = row["hostname"] });
                command.Parameters.Add(new SqlParameter("@type1", SqlDbType.VarChar) { Value = row["type1"] });
                command.Parameters.Add(new SqlParameter("@type2", SqlDbType.VarChar) { Value = row["type2"] });

                var affectedRows = command.ExecuteNonQuery();
            }
            MaterialMessageBox.Show("Data was sent successfull", "Intellilog", MessageBoxButtons.OK, MessageBoxIcon.Information);
            connection.Close();
        }

        //mySql connection.
        private MySqlConnection GetMySQLConnection()
        {
            MySqlConnectionStringBuilder connectionBuilder = new MySqlConnectionStringBuilder
            {
                Server = "127.0.0.1",
                Database = "intellilog",
                UserID = "root",
                Password = ""
            };
            MySqlConnection connection = new MySqlConnection(connectionBuilder.ToString());
            return connection;

        }

        //sql server connection
        private SqlConnection GetSqlServerConnection()
        {
            string connectionString = @"Data Source=127.0.0.1; Initial Catalog=intellilog2; User ID=sa; Password=ilog123";
            SqlConnection connection = new SqlConnection(connectionString);
            return connection;
        }

//the update buttons that take data from mySQL to MSSql
        private void btnUpdate_Click_1(object sender, EventArgs e)
        {
            var table = GetDataTableFromMySQL();
            AddToMsSQL(table);
            lblLastID.Text = GetLastID().ToString();
            GetLastID();
            WebUsageSQLConnection();
        }

