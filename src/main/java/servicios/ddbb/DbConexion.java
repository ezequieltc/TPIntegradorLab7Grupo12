package servicios.ddbb;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

public class DbConexion {

	private Properties prop = new Properties();
	private String dbUser = "";
	private Path propPath = Paths.get("../propiedades/propiedades.properties");
	private Path rutaAbsoluta = propPath.toAbsolutePath();
	
	public DbConexion(){
		getProperties();
		this.dbUser = prop.getProperty("DBUSERNAME");
		System.out.println("Prueba de props: " + dbUser);
		System.out.println("Prueba de props: " + System.getProperty("user.dir"));
	}

	private void getProperties() {
		try {
			prop.load(new FileReader(rutaAbsoluta.toString()));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
