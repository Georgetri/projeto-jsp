package filter;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import connection.SingleConnectionBanco;
import dao.DaoversionadorBanco;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = { "/principal/*" }) /*
												 * Interface Filter, @WebFilter Intercepta todas requisições que vierem
												 * do projeto ou mapeamento
												 */
public class FilterAutenticacao extends HttpFilter implements Filter {

	private static Connection connection;

	public FilterAutenticacao() {

	}

	/*
	 * Encerra os processos quando os servidor é parado Ex: mataria os processos de
	 * coneção com o banco
	 */
	public void destroy() {

		try {
			connection.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

	/*
	 * Onde tudo acontece, intercepta todas as requisições do projeto e dá respostas
	 * no sistema Tudo que fizer no sistema, passa por aqui, Ex: validação de
	 * autenticação, dar commit e rollback no banco, validar e fazer
	 * redirecionamento de páginas, etc
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		try {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpSession session = req.getSession();
			String usuarioLogado = (String) session.getAttribute("usuario");
			String urlParaAutenticar = req.getServletPath();/* url que está sendo acessada */

			/* Validar se está logado, senão direciona para tela der login */
			if (usuarioLogado == null && !urlParaAutenticar.equalsIgnoreCase("/principal/ServletLogin")) {

				RequestDispatcher redireciona = request.getRequestDispatcher("/index.jsp?url=" + urlParaAutenticar);
				request.setAttribute("msg", "Por favor, realize o login!");
				redireciona.forward(request, response);
				return;/* Para a execução e redireciona para oo login */

			} else {
				chain.doFilter(request, response);
			}

			connection.commit();/* Deu tudo certo, então comita(salva8 ) as alterações no banco de dados */

		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);

			try {
				connection.rollback();
			} catch (SQLException e1) {

				e1.printStackTrace();
			}
		}

	}

	/*
	 * Executado qdo inicia o sistema, inicia os processos ou recursos qdo o
	 * servidor sobe o projeto Ex.: Iniciar a conexão com o banco
	 */

	public void init(FilterConfig fConfig) throws ServletException {
		connection = SingleConnectionBanco.getConnection();
		
		DaoversionadorBanco daoversionadorBanco = new DaoversionadorBanco();
		
		String caminhoPastaSQL = fConfig.getServletContext().getRealPath("versionadorbancosql") + File.separator;
		
		File[] filesSql = new File(caminhoPastaSQL).listFiles();
		
		try {
			
			for (File file : filesSql) {
				
				boolean arquivoJaRodado = daoversionadorBanco.arquivoSqlRodado(file.getName());
				
				if(!arquivoJaRodado) {
					
					FileInputStream entradaArquivo = new FileInputStream(file);
					
					Scanner lerArquivo = new Scanner(entradaArquivo,"UTF-8");
					
					StringBuilder sql = new StringBuilder(); 
					
					while(lerArquivo.hasNext()) {
						
						sql.append(lerArquivo.nextLine());
						sql.append("\n");
					}
					connection.prepareStatement(sql.toString()).execute();
					daoversionadorBanco.gravaArquivoSqlRodado(file.getName());
					connection.commit();
					lerArquivo.close();
				}
				
			}			
			
		} catch (Exception e) {
			
			try {
				connection.rollback();
				
			} catch (SQLException e1) {
				
				e1.printStackTrace();
			}
			e.printStackTrace();
		}

	}

}








