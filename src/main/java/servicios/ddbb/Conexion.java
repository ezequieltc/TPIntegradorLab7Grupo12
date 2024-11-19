package servicios.ddbb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class Conexion {
	
	public static Conexion instancia;
	private Connection connection;
	private Properties properties;
	private String user;
	private String pass;
	private String path;
	private String dbDriver;
	
	private Conexion()
	{
		try
		{
			properties = new Properties();
			getPropiedades();
			user =  properties.getProperty("DBUSERNAME");
			pass = properties.getProperty("DBPASSWORD");
			path = properties.getProperty("DBPATH");
			dbDriver = properties.getProperty("DBDRIVER");
			Class.forName(dbDriver);
			
			this.connection = DriverManager.getConnection(path,user,pass);
			this.connection.setAutoCommit(false);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public static Conexion getConexion()   
	{		
		if(instancia == null)
		{
			instancia = new Conexion();
		}
		return instancia;
	}

    public Connection getSQLConexion() {
        try {
            if (this.connection == null || this.connection.isClosed()) {
                this.connection = DriverManager.getConnection(path, user, pass);
                this.connection.setAutoCommit(false);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return this.connection;
    }
	
	public void cerrarConexion()
	{
		try 
		{
			this.connection.close();
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		instancia = null;
	}
	
	private void getPropiedades() {
		try {
			properties.load(getClass().getResourceAsStream("../../propiedades/propiedades.properties"));
		} catch (IOException e) {
			System.err.println("Error al leer archivo de propiedades");
			e.printStackTrace();
		}
	}

}
