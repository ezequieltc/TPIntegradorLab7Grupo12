package Presentacion.Auth;

import java.util.List;

public class MenuItem {
    private String name;
    private String link;
    private List<MenuItem> subMenu;

    public MenuItem(String name, String link) {
        this.name = name;
        this.link = link;
    }

    public MenuItem(String name, List<MenuItem> subMenu) {
        this.name = name;
        this.subMenu = subMenu;
    }

    public String getName() {
        return name;
    }

    public String getLink() {
        return link;
    }

    public List<MenuItem> getSubMenu() {
        return subMenu;
    }

    public boolean hasSubMenu() {
        return subMenu != null && !subMenu.isEmpty();
    }
}
