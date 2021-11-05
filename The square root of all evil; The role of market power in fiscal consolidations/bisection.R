################# Bisection
################# João Costa-Filho
################# sites.google.com/site/joaoricardocostafilho
################# Twitter: @costafilhojoao

"
        Parameters:
        ----------
        f: function
        a: inferior limit
        b: superior limit
        max_iter: maximum number of iterations
"

bisection <- function( f, a, b, tol ){
  
  while( abs(b - a) > tol ) {
    
    if ( sign( f( ( a + b )/ 2 ) ) == sign(  f( a ) ) ) {
      
      a = ( a + b )/ 2
      
    } 
    
    else if ( sign( f( ( a + b )/ 2 ) ) == sign(  f( b ) ) ) { 
      
      b = ( a + b )/ 2
      
      } 
    
  }

  ( a + b )/ 2
  
}
