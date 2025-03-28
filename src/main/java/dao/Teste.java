package dao;

public class Teste {
	public static void main(String[] args) {
		
		Double cadastros = 34.0;
		
		Double porpagina = 5.0;
		
		Double pagina = cadastros / porpagina;
		
		Double resto = pagina % 2;
		
		if(resto > 0) {
			pagina++;
		}
		
		System.out.println(pagina.intValue());
		
	}

}
