package org.myservlets;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.mockito.Mockito.*;

class StartServletTest {

    private StartServlet servlet;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private HttpSession session;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        servlet = new StartServlet();
        when(request.getSession()).thenReturn(session);
    }

    @Test
    void testDoPostNoParameter() throws Exception {
        when(request.getParameter("action")).thenReturn(null);

        servlet.doPost(request, response);

        verify(session, never()).setAttribute(anyString(), any());
        verify(response).sendRedirect("start");
    }
}
