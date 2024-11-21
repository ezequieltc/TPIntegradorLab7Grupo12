import Dao.*;
import DaoImpl.*;
import Dominio.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import DaoImpl.TipoUsuarioDaoImpl;

public class Main {

    public static void main(String[] args) {

        IUsuarioDao usuarioDao = new UsuarioDaoImpl();
        TipoUsuarioDaoImpl tipoUsuarioDao = new TipoUsuarioDaoImpl();

        TipoUsuario tipoUsuario = tipoUsuarioDao.getTipoUsuario(1);

        if (tipoUsuario == null) {
            System.out.println("El tipo de usuario no existe en la base de datos.");
            return;
        }

        Usuario nuevoUsuario = new Usuario(0, tipoUsuario, "johndoe", "password123", new Date(), true);
        try {
        	usuarioDao.insert(nuevoUsuario);
        	System.out.println("Usuario agregado exitosamente");
        }catch(Exception e) {
        	System.out.println("Error al agregar usuario");
        }

        List<Usuario> usuarios = usuarioDao.readAll(1).getData();
        if (!usuarios.isEmpty()) {
            Usuario usuarioABorrar = usuarios.get(usuarios.size() - 1);
            usuarioABorrar.setEstado(false);
            if (usuarioDao.delete(usuarioABorrar)) {
                System.out.println("Usuario dado de baja exitosamente");
            } else {
                System.out.println("Error al dar de baja usuario");
            }
        }

        if (!usuarios.isEmpty()) {
            Usuario usuarioAActualizar = usuarios.get(usuarios.size() - 1);
            usuarioAActualizar.setUsuario("johndoe_updated");
            if (usuarioDao.update(usuarioAActualizar)) {
                System.out.println("Usuario actualizado exitosamente: ");
            } else {
                System.out.println("Error al actualizar usuario");
            }
        }

        System.out.println("Listado de todos los usuarios:");
        usuarios = usuarioDao.readAll(1).getData();
        for (Usuario usuario : usuarios) {
            System.out.println("ID: " + usuario.getId() +
                    ", Tipo de Usuario: " + usuario.getTipoUsuario().getDescripcion() + 
                    ", Usuario: " + usuario.getUsuario() +
                    ", Contraseña: " + usuario.getContrasena() +
                    ", Fecha de Creación: " + usuario.getFechaCreacion() +
                    ", Estado: " + (usuario.getEstado() ? "Activo" : "Inactivo"));
        }
        
        //persona
        
        IPersonaDao personaDao = new PersonaDaoImpl();
        TipoSexoDaoImpl tipoSexoDao = new TipoSexoDaoImpl();
        

        TipoSexo tipoSexo = tipoSexoDao.getTipoSexo(1);
        Usuario usuario = usuarioDao.getUsuario(1);

        if (tipoSexo == null || usuario == null) {
            System.out.println("El tipo de sexo o el usuario no existen en la base de datos.");
            return;
        }

        Persona nuevaPersona = new Persona(0, usuario, tipoSexo, "12345678", "20123456789", "Juan", "Pérez", 
                                           "Argentina", new Date(), "Av. Siempre Viva 123", "Ciudad", 
                                           "Provincia", "juan.perez@example.com", "123456789", true);

        try {
        	personaDao.insert(nuevaPersona);
        	System.out.println("Persona agregada exitosamente");
        	
        }catch(Exception e) {
        
        	System.out.println("Error al agregar persona");
        }

        List<Persona> personas = personaDao.readAll(1).getData();
        if (!personas.isEmpty()) {
            Persona personaABorrar = personas.get(personas.size() - 1);
            personaABorrar.setEstado(false);
            if (!personaDao.delete(personaABorrar.getId())) {
                System.out.println("Persona dada de baja exitosamente");
            } else {
                System.out.println("Error al dar de baja persona");
            }
        }

        if (!personas.isEmpty()) {
            Persona personaAActualizar = personas.get(personas.size() - 1);
            personaAActualizar.setNombre("Juan Actualizado");
            if (personaDao.update(personaAActualizar)) {
                System.out.println("Persona actualizada exitosamente");
            } else {
                System.out.println("Error al actualizar persona");
            }
        }

        System.out.println("Listado de todas las personas:");
        personas = personaDao.readAll(1).getData();
        for (Persona persona : personas) {
            System.out.println("ID: " + persona.getId() +
                    ", Persona: " + persona.getUsuario().getUsuario() +
                    ", Tipo de Sexo: " + persona.getTipoSexo().getDescripcion() +
                    ", DNI: " + persona.getDni() +
                    ", CUIL: " + persona.getCuil() +
                    ", Nombre: " + persona.getNombre() +
                    ", Apellido: " + persona.getApellido() +
                    ", Nacionalidad: " + persona.getNacionalidad() +
                    ", Fecha de Nacimiento: " + persona.getFechaNacimiento() +
                    ", Dirección: " + persona.getDireccion() +
                    ", Localidad: " + persona.getLocalidad() +
                    ", Provincia: " + persona.getProvincia() +
                    ", Email: " + persona.getEmail() +
                    ", Teléfono: " + persona.getTelefono() +
                    ", Estado: " + (persona.isEstado() ? "Activo" : "Inactivo"));
        }
    }
    
}
