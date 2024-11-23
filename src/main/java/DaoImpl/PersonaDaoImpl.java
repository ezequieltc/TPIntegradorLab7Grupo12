package DaoImpl;

import java.sql.Connection;
import servicios.ddbb.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

import Dao.IPersonaDao;
import Dominio.Persona;
import Dominio.TipoSexo;
import Dominio.TipoUsuario;
import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;
import excepciones.PersonaExistenteExcepcion;
import NegocioImpl.UsuarioNegocioImpl;

import servicios.ddbb.*;
public class PersonaDaoImpl implements IPersonaDao {

	private static final String insert = "insert into personas(id_usuario, id_sexo, dni, cuil, nombre, apellido, nacionalidad, fecha_nacimiento, "
			+ "direccion, localidad, provincia, email, telefono, estado) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String delete = "update personas set estado = ? WHERE id_usuario = ?";
	private static final String update = "update personas set id_usuario = ?, id_sexo = ?, dni = ?, cuil = ?, nombre = ?, apellido = ?, "
	        + "nacionalidad = ?, fecha_nacimiento = ?, direccion = ?, localidad = ?, provincia = ?, email = ?, telefono = ?, estado = ? WHERE id_persona = ?";
	private static final String readall = "select * from personas where estado = 1";
	//private static final String readall = "select * from personas where estado = 1 limit ? offset ?";
	private static final String read = "select id_persona, id_usuario, id_sexo, dni, cuil, nombre, apellido, nacionalidad, fecha_nacimiento,"
			+ "direccion, localidad, provincia, email, telefono, estado from personas where id_persona = ? and estado = 1";
	private static final String readDni = "select id_persona, id_usuario, id_sexo, dni, cuil, nombre, apellido, nacionalidad, fecha_nacimiento,"
			+ "direccion, localidad, provincia, email, telefono, estado from personas where dni = ?";
	private static final String readByUser = "select id_persona, id_usuario, id_sexo, dni, cuil, nombre, apellido, nacionalidad, fecha_nacimiento,"
			+ "direccion, localidad, provincia, email, telefono, estado from personas where id_usuario = ? and estado = 1";
	private static final String siguiente = "select max(id_persona) from personas";
	private static final String count = "select count(*) as total FROM personas";
	private TipoSexoDaoImpl tipoSexoDao;
	private UsuarioDaoImpl usuarioDao;
	
	public PersonaDaoImpl() {
		this.tipoSexoDao = new TipoSexoDaoImpl();
		this.usuarioDao = new UsuarioDaoImpl();
	}
	
	@Override
	public void insert(Persona persona) throws SQLException {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		statement = conexion.prepareStatement(insert);
        statement.setInt(1, persona.getUsuario().getId());  
        statement.setInt(2, persona.getTipoSexo().getId());
        statement.setString(3, persona.getDni());
        statement.setString(4, persona.getCuil());
        statement.setString(5, persona.getNombre());
        statement.setString(6, persona.getApellido());
        statement.setString(7, persona.getNacionalidad());
        statement.setDate(8, new java.sql.Date(persona.getFechaNacimiento().getTime()));
        statement.setString(9, persona.getDireccion());
        statement.setString(10, persona.getLocalidad());
        statement.setString(11, persona.getProvincia());
        statement.setString(12, persona.getEmail());
        statement.setString(13, persona.getTelefono());
        statement.setBoolean(14, persona.isEstado());
		statement.executeUpdate();
	}

	@Override
	public boolean delete(int id) {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean isdeleteExitoso = false;
		try 
		{
			statement = conexion.prepareStatement(delete);
			statement.setBoolean(1, false);
			statement.setString(2, Integer.toString(id));
			if(statement.executeUpdate() > 0)
			{
				conexion.commit();
				isdeleteExitoso = true;
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return isdeleteExitoso;
	}


	
	public boolean update(Persona persona) {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean isUpdateExitoso = false;
		try
		{
			statement = conexion.prepareStatement(update);
	        statement.setInt(1, persona.getUsuario().getId());  
	        statement.setInt(2, persona.getTipoSexo().getId());
	        statement.setString(3, persona.getDni());
	        statement.setString(4, persona.getCuil());
	        statement.setString(5, persona.getNombre());
	        statement.setString(6, persona.getApellido());
	        statement.setString(7, persona.getNacionalidad());
	        statement.setDate(8, new java.sql.Date(persona.getFechaNacimiento().getTime()));
	        statement.setString(9, persona.getDireccion());
	        statement.setString(10, persona.getLocalidad());
	        statement.setString(11, persona.getProvincia());
	        statement.setString(12, persona.getEmail());
	        statement.setString(13, persona.getTelefono());
	        statement.setBoolean(14, persona.isEstado());
	        statement.setInt(15, persona.getId());
			if(statement.executeUpdate() > 0)
			{
				conexion.commit();
				isUpdateExitoso = true;
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
			try {
				conexion.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
		return isUpdateExitoso;
	}

	@Override
	public PaginatedResponse<Persona> readAll(int pagina) {
		PreparedStatement statement;
		ResultSet resultSet;
		ArrayList<Persona> personas = new ArrayList<Persona>();
		Conexion conexion = Conexion.getConexion();
		final int limit = 5;
//		int offset = limit * (pagina-1);
		try 
		{
			statement = conexion.getSQLConexion().prepareStatement(readall);
//			statement.setInt(1, limit);
//			statement.setInt(2, offset);
			resultSet = statement.executeQuery();
			while(resultSet.next())
			{
				Persona _persona = getPersona(resultSet);
				if (_persona.getUsuario().getTipoUsuario().getId() != 1) {
					personas.add(getPersona(resultSet));					
				}
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		int totalRegistros = getTotalRegistros(conexion);
		
		return new PaginatedResponse<Persona>(personas, totalRegistros, pagina, limit);
	}
	
    private int getTotalRegistros(Conexion conexion) {
        try (PreparedStatement countStatement = conexion.getSQLConexion().prepareStatement(count);
             ResultSet countResult = countStatement.executeQuery()) {
            if (countResult.next()) {
                return countResult.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
	
	private Persona getPersona(ResultSet resultSet) throws SQLException {
	    int id = resultSet.getInt("id_persona");
	    int idUsuario = resultSet.getInt("id_usuario");
	    int idSexo = resultSet.getInt("id_sexo");
	    String dni = resultSet.getString("dni");
	    String cuil = resultSet.getString("cuil");
	    String nombre = resultSet.getString("nombre");
	    String apellido = resultSet.getString("apellido");
	    String nacionalidad = resultSet.getString("nacionalidad");
	    Date fechaNacimiento = resultSet.getDate("fecha_nacimiento");
	    String direccion = resultSet.getString("direccion");
	    String localidad = resultSet.getString("localidad");
	    String provincia = resultSet.getString("provincia");
	    String email = resultSet.getString("email");
	    String telefono = resultSet.getString("telefono");
	    boolean estado = resultSet.getBoolean("estado");

	    TipoSexo tipoSexo = tipoSexoDao.getTipoSexo(idSexo);
	    Usuario usuario = usuarioDao.getUsuario(idUsuario);
	    return new Persona(id, usuario, tipoSexo, dni, cuil, nombre, apellido, nacionalidad, fechaNacimiento, direccion, localidad, provincia, email, telefono, estado);
	}

	public Persona getPersona(int id) {
	    Persona persona = null;
	    try {
	        Conexion conn = Conexion.getConexion();
	        Connection connection = conn.getSQLConexion();
	        PreparedStatement ps = connection.prepareStatement(read);
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            persona = new Persona();
	            persona.setId(rs.getInt("id_persona"));
	            
	            int usuarioId = rs.getInt("id_usuario");
	            Usuario usuario = usuarioDao.getUsuario(usuarioId);
	            persona.setUsuario(usuario);
	            
	            int tipoSexoId = rs.getInt("id_sexo");
	            TipoSexo tipoSexo = tipoSexoDao.getTipoSexo(tipoSexoId);
	            persona.setTipoSexo(tipoSexo);
	            
	            persona.setDni(rs.getString("dni"));
	            persona.setCuil(rs.getString("cuil"));
	            persona.setNombre(rs.getString("nombre"));
	            persona.setApellido(rs.getString("apellido"));
	            persona.setNacionalidad(rs.getString("nacionalidad"));
	            persona.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
	            persona.setDireccion(rs.getString("direccion"));
	            persona.setLocalidad(rs.getString("localidad"));
	            persona.setProvincia(rs.getString("provincia"));
	            persona.setEmail(rs.getString("email"));
	            persona.setTelefono(rs.getString("telefono"));
	            persona.setEstado(rs.getBoolean("estado"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return persona;
	}
	
	public Persona getPersonaPorUsuario(int idUsuario) {
		Persona persona = null;
	    try {
	        Conexion conn = Conexion.getConexion();
	        Connection connection = conn.getSQLConexion();
	        PreparedStatement ps = connection.prepareStatement(readByUser);
	        ps.setInt(1, idUsuario);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            persona = new Persona();
	            persona.setId(rs.getInt("id_persona"));
	            
	            int usuarioId = rs.getInt("id_usuario");
	            Usuario usuario = usuarioDao.getUsuario(usuarioId);
	            persona.setUsuario(usuario);
	            
	            int tipoSexoId = rs.getInt("id_sexo");
	            TipoSexo tipoSexo = tipoSexoDao.getTipoSexo(tipoSexoId);
	            persona.setTipoSexo(tipoSexo);
	            
	            persona.setDni(rs.getString("dni"));
	            persona.setCuil(rs.getString("cuil"));
	            persona.setNombre(rs.getString("nombre"));
	            persona.setApellido(rs.getString("apellido"));
	            persona.setNacionalidad(rs.getString("nacionalidad"));
	            persona.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
	            persona.setDireccion(rs.getString("direccion"));
	            persona.setLocalidad(rs.getString("localidad"));
	            persona.setProvincia(rs.getString("provincia"));
	            persona.setEmail(rs.getString("email"));
	            persona.setTelefono(rs.getString("telefono"));
	            persona.setEstado(rs.getBoolean("estado"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return persona;
	}
	
	@Override
	public int calcularSiguienteId() {
        int ultimoId = 0;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
        	PreparedStatement statement = conexion.prepareStatement(siguiente);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                ultimoId = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ultimoId + 1;
	}
	
	public Persona getPersonaPorDni(String dni) {
		Persona persona = null;
	    try {
	        Conexion conn = Conexion.getConexion();
	        Connection connection = conn.getSQLConexion();
	        PreparedStatement ps = connection.prepareStatement(readDni);
	        ps.setString(1, dni);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            persona = new Persona();
	            persona.setId(rs.getInt("id_persona"));
	            
	            int usuarioId = rs.getInt("id_usuario");
	            Usuario usuario = usuarioDao.getUsuario(usuarioId);
	            persona.setUsuario(usuario);
	            
	            int tipoSexoId = rs.getInt("id_sexo");
	            TipoSexo tipoSexo = tipoSexoDao.getTipoSexo(tipoSexoId);
	            persona.setTipoSexo(tipoSexo);
	            
	            persona.setDni(rs.getString("dni"));
	            persona.setCuil(rs.getString("cuil"));
	            persona.setNombre(rs.getString("nombre"));
	            persona.setApellido(rs.getString("apellido"));
	            persona.setNacionalidad(rs.getString("nacionalidad"));
	            persona.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
	            persona.setDireccion(rs.getString("direccion"));
	            persona.setLocalidad(rs.getString("localidad"));
	            persona.setProvincia(rs.getString("provincia"));
	            persona.setEmail(rs.getString("email"));
	            persona.setTelefono(rs.getString("telefono"));
	            persona.setEstado(rs.getBoolean("estado"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return persona;
	}

}
