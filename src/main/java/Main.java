import Dao.IUsuarioDao;
import DaoImpl.UsuarioDaoImpl;
import Dominio.Usuario;
import Dominio.TipoUsuario;

import java.util.ArrayList;
import java.util.Date;

import Dao.IUsuarioDao;
import DaoImpl.UsuarioDaoImpl;
import DaoImpl.TipoUsuarioDaoImpl;  // Asegúrate de tener el Dao de TipoUsuario
import Dominio.Usuario;
import Dominio.TipoUsuario;

import java.util.ArrayList;
import java.util.Date;

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
        if (usuarioDao.insert(nuevoUsuario)) {
            System.out.println("Usuario agregado exitosamente");
        } else {
            System.out.println("Error al agregar usuario");
        }

        ArrayList<Usuario> usuarios = usuarioDao.readAll();
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
        usuarios = usuarioDao.readAll();
        for (Usuario usuario : usuarios) {
            System.out.println("ID: " + usuario.getId() +
                    ", Tipo de Usuario: " + usuario.getTipoUsuario().getDescripcion() + 
                    ", Usuario: " + usuario.getUsuario() +
                    ", Contraseña: " + usuario.getContrasena() +
                    ", Fecha de Creación: " + usuario.getFechaCreacion() +
                    ", Estado: " + (usuario.isEstado() ? "Activo" : "Inactivo"));
        }
    }
}
