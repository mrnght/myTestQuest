package org.myservlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/start")
public class StartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if(session.getAttribute("wakeUp") == null) {
            session.setAttribute("wakeUp", true);
            session.setAttribute("win", false);
            session.setAttribute("lose", false);
            session.setAttribute("area", Area.START_LOCATION);
        }

        getServletContext().getRequestDispatcher("/start.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "sheep" -> {session.setAttribute("area", Area.SHEEP);}
                case "loseSheep" -> {session.setAttribute("lose", true);}
                case "bridge" -> {session.setAttribute("area", Area.CAPTAIN_BRIDGE);}
                case "loseBridge" -> {session.setAttribute("lose", true);}
                case "sayTrueQ" -> {
                    session.setAttribute("win", true);
                    session.setAttribute("area", Area.HOME);
                }
                case "sayLieQ" -> {session.setAttribute("lose", true);}
            }

            if((boolean)(session.getAttribute("lose")) == true) {
                session.setAttribute("area", Area.SPACE);
            }
        }

        response.sendRedirect("start");
    }
}
