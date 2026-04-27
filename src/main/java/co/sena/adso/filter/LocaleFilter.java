package co.sena.adso.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class LocaleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String langParam = request.getParameter("lang");
        HttpSession session = req.getSession();

        if (langParam != null) {
            if (langParam.equals("es") || langParam.equals("en") || langParam.equals("it")) {
                session.setAttribute("lang", langParam);
            }
        } else if (session.getAttribute("lang") == null) {
            session.setAttribute("lang", "es");
        }
        
        chain.doFilter(request, response);
    }
}