package Bitlab.servlet;

import Database.Comments;
import Database.DBManager;
import Database.Hotels;
import Database.Users;
import org.apache.commons.lang.StringEscapeUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/addcomment")
public class AddCommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Users currentUser = (Users)request.getSession().getAttribute("USER");
        if(currentUser!=null) {

            request.setCharacterEncoding("utf8");
            Long hotelId = Long.parseLong(request.getParameter("hotel_id"));
            Hotels hotel = DBManager.getHotel(hotelId);

        if (hotel!=null){
            String commentText = request.getParameter("comment");
            Comments comment = new Comments();
            comment.setComment(StringEscapeUtils.escapeHtml(commentText));

            comment.setUser(currentUser);
            comment.setHotel(hotel);

            DBManager.addComment(comment);
            response.sendRedirect("/details?id=" + hotel.getId()+ "#addCommentDiv");
                


            }else {
                response.sendRedirect("/");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
