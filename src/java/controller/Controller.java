package controller;

import entities.Usuario;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import util.JPAUtil;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String op = request.getParameter("op");
        Query q = null;
        List persons = null;
        List movies = null;
        Usuario usuario = null;
        EntityTransaction t = null;
        String msg = null;

        // Singleton
        EntityManager em = (EntityManager) session.getAttribute("em");
        if (em == null) {
            // Create the EntityManager
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }

        switch (op) {
            case "inicio": {
                // actuar en consecuencia
                // .........
                // session.setAttribute("Key", objeto);
                // request.setAttribute("Key", objeto
                q = em.createQuery("SELECT p FROM Person p");

                persons = q.getResultList();
                session.setAttribute("persons", persons);
                request.getRequestDispatcher("home.jsp").forward(request, response);

                break;
            }
            case "menu": {
                String quieren = request.getParameter("quieren");
                if (quieren.equals("person")) {
                    q = em.createQuery("SELECT p FROM Person p");
                    persons = q.getResultList();
                    session.setAttribute("persons", persons);
                    session.removeAttribute("movies");
                } else {
                    q = em.createQuery("SELECT m FROM Movie m");
                    movies = q.getResultList();
                    session.setAttribute("movies", movies);
                    session.removeAttribute("persons");
                }
                request.getRequestDispatcher("home.jsp").forward(request, response);
                break;
            }
            case "login": {
                String dni = request.getParameter("dni");
                String nombre = request.getParameter("nombre");
                usuario = em.find(Usuario.class, dni);

                if (usuario == null) {
                    usuario = new Usuario(dni);
                    usuario.setNombre(nombre);
                    t = em.getTransaction();
                    t.begin();
                    em.persist(usuario);
                    t.commit();
                    msg = "Registrado usuario";
                } else {
                    msg = "Login ok...";
                }
                session.setAttribute("msg", msg);
                session.setAttribute("usuario", usuario);
                request.getRequestDispatcher("home.jsp").forward(request, response);
                break;
            }
            case "logout": {
                session.removeAttribute("usuario");
                msg = "Bye";
                session.setAttribute("msg", msg);

                request.getRequestDispatcher("home.jsp").forward(request, response);
                break;
            }

            default:
                throw new IllegalArgumentException("Unexpected value: " + op);
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
