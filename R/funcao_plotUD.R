#' Plot Uniform Discrete Probability Distribution
#' 
#' Plot Uniform Discrete Probability Distribution and highlight probability of some values from i to f. There are some default to values
#' to each parameter in function.
#'
#' @param a lower limits of the distribution
#' @param b upper limits of the distribution
#' @param prob logical (default = FALSE), if TRUE highlight some values of the probability of random variable from 'i' to 'f'
#' @param i highlight probability from this intial value of distribution
#' @param f highlight probability from 'i' to this final value of distribution
#'
#' @export
#'
#' @examples
#' plotUD(a = 0, b = 4, prob = TRUE, i = 2, f = 4)



plotUD = function(a = 0, b = 4, prob = FALSE, i = 2, f = 4, out = TRUE){
  if(prob == TRUE){
    if (i < a | i > b) stop("'i' deve estar entre 'a' e 'b' ")
    if (f > b | f < i) stop("'f' deve estar entre 'a' e 'b' e menor que 'i' ")
  }
  corP             = "#14213d" # darkblue
  corPhigh         = "#fca311" # orange
  x  = seq(a,b,1)
  px = rep(1/(b-a+1),b-a+1)
  plot(x, px, 
       type = "h", 
       bty  = "n", 
       xaxt = "n", # não plota eixo x
       yaxt = "n", # não plota eixo y,
       xlab = "x",
       ylab = bquote( p[X](x) ),
       col = corP)
  
  points(x,px,pch=16, col = corP)
  axis(side=1,at=seq(a-1,b+1,1),lwd=3)
  axis(side=2,at=seq(0,1,0.05),lwd=3)
  
  exp_value = (a+b)/2
  var_value = ((b-a+1)^2 - 1)/12
  # Legendas
  legenda <- list( bquote( "E[X] =" ~ .(exp_value)) ,
                   bquote( "V(X) =" ~ .(var_value))
                   )
  
  mtext(side = 3, do.call(expression, legenda), line=-1:-2, adj=1, col=c("gray", "gray"))
  
  if(prob == TRUE){
    par(new=TRUE)
    d = i:f
    pd = rep(1/(b-a+1),f-i+1)
    plot(d, pd, 
          type="h", 
          bty="n", 
          xaxt="n", # não plota eixo x
          yaxt="n", # não plota eixo y,
          xlab = NA,
          ylab = NA,
          col=corPhigh,
          lwd = 2,
          xlim= c(a,b))
    points(x,px,pch=16)
  }
  if(out == TRUE){
  dt = data.frame(x = x, px = px)
  return(knitr::kable(dt))
  }else{
    return(invisible(NULL))
  }
}


#' Plot Cumultaive Uniform Discrete Probability Distribution
#'
#' @param a lower limits of the distribution
#' @param b upper limits of the distribution
#'
#' @export
#'
#' @examples
#' plotcUD(a = 0, b = 4)

plotcUD = function(a = 0, b = 4){
  x  = seq(a,b,1)
  px = rep(1/(b-a+1),b-a+1)
  cpx = cumsum(px)
  plot(x, cpx, 
       xlim = c(a,b),
       ylim = c(0,1),
       type = "n", 
       bty="n", 
       xaxt="n", # não plota eixo x
       yaxt="n", # não plota eixo y,
       xlab = "x",
       ylab = bquote( F[X](x) ))
  axis(side=1,at=seq(a-1,b+1,1) ,lwd=3)
  axis(side=2,at=seq(0,1,0.10),lwd=3)
  segments(x,
           cpx,
           c(x[-1], x[length(x)]+1),
           cpx)
  
  points(x,cpx,pch=16)
  points(x[-1],cpx[-length(x)],pch=1)
  abline(h = 0, col = "gray", lty = "dashed")
  abline(h = 1, col = "gray", lty = "dashed")
}


#' Plot Binomial Discrete Probability Distribution
#' 
#' X represent the number of successes in a sequence of `n` Bernoulli trials.
#'
#' @param n number of trials (zero or more).
#' @param p probability of success on each trial.
#' @param hlt logical (default is FALSE); if TRUE, probabilities P[i ≤ X ≤ f] are highlighted in green color in plot 
#' @param i,f highlight probability from i' initial value of distribution to 'f' final value of distribution
#'
#' @export
#'
#' @examples
#' plotBIN(n = 50, p = 0.15, hlt = TRUE, i = 2, f = 4)

plotBIN = function(n, p, hlt = FALSE, i = 2, f = 4, out = TRUE){
  if(hlt == TRUE){
    if (n < 0 | p > 1) stop("'n' deve ser maior que 0, 'p' deve ser menor ou igual a 1 ")
    if (p < 0)         stop("'p' deve estar entre 0 e 1 ")
  }
  
  x  = seq(0,n,1)
  px = dbinom(x, size = n, prob = p)
  plot(x, px, 
       type = "h", 
       bty="n", 
       xaxt="n", # não plota eixo x
       yaxt="n", # não plota eixo y,
       xlab = "x",
       ylab = bquote( p[X](x) ))
  
  points(x, px, pch=16)
  axis(side=1,at=seq(0,n,1),lwd=3)
  axis(side=2,at=seq(0,1,0.05),lwd=3)
  # Calculo do valor esperado
  exp_value = n*p
  var_value = n*p*(1-p)
  # Legendas
  legenda <- list( bquote( "E[X] =" ~ .(exp_value)) ,
                   bquote( "V(X) =" ~ .(var_value))
  )
  
  mtext(side = 3, do.call(expression, legenda), line=-1:-2, adj=1, col=c("gray", "gray"))
  xl = par("usr")[1:2]
  yl = par("usr")[3:4]
  if(hlt == TRUE){
    par(new=TRUE)
    par(xaxs="i",yaxs="i")
    d  = i:f
    pd = px[(i+1):(f+1)]
    plot( d, pd, type="h", 
          bty="n", 
          xaxt="n", # não plota eixo x
          yaxt="n", # não plota eixo y,
          xlab = NA,
          ylab = NA,
          col="green",
          xlim = as.numeric(format(xl,digits = 6)),
          ylim = as.numeric(format(yl,digits = 6)))
    points(x,px,pch=16)
  }
  if(out == TRUE){
    dt = data.frame(x = x, px = px)
    return(knitr::kable(dt))
  }else{
    return(invisible(NULL))
  }
}



#' Plot Negative Binomial Distribution
#' 
#' X represent the number of failures in a sequence of Bernoulli trials before a `r` success occurs.
#'
#' @param p probability of success in each trial. 0 < p <= 1.
#' @param r target for number of successful trials. Must be strictly positive, need not be integer.
#' @param n.plot number of observations for the plot, by default will be ploted 50 observations
#' @param hlt logical (default is FALSE); if TRUE, probabilities P[i ≤ X ≤ f] are highlighted in green color in the plot 
#' @param i,f highlight probability from i' initial value of distribution to 'f' final value of distribution
#'
#' @export
#'
#' @examples
#' plotBINNEG(p = 0.15, r = 3, n.plot = 50 , hlt = TRUE, i = 2, f = 4)

plotBINNEG = function(p, r, n.plot = 50 , hlt = FALSE, i = 2, f = 4, out = TRUE){
    if (p < 0 | p > 1) stop("'p' deve estar entre 0 e 1 ")
  n = n.plot
  x  = seq(0,n,1)
  px = dnbinom(x, size = r,prob = p)
  plot(x, px, 
       type = "h", 
       bty  = "n", 
       xaxt = "n", # não plota eixo x
       yaxt = "n", # não plota eixo y,
       xlab = "x",
       ylab = bquote( p[X](x) ))
  
  points(x, px, pch=16)
  axis(side=1,at=seq(0,n,1),lwd.ticks = 1,lwd=3)
  #axis(side=2,at=seq(0,1,0.05),lwd=3)
  axis(side=2,lwd=3)
  # Calculo do valor esperado
  exp_value = (r*(1-p))/p
  var_value = (r*(1-p))/(p^2)
  # Legendas
  legenda <- list( bquote( "E[X] =" ~ .(exp_value)) ,
                   bquote( "V(X) =" ~ .(var_value))
  )
  
  mtext(side = 3, do.call(expression, legenda), line=-1:-2, adj=1, col=c("gray", "gray"))
  xl = par("usr")[1:2]
  yl = par("usr")[3:4]
  if(hlt == TRUE){
    par(new=TRUE)
    par(xaxs="i",yaxs="i")
    d  = i:f
    pd = px[(i+1):(f+1)]
    plot( d, pd, type="h", 
          bty="n", 
          xaxt="n", # não plota eixo x
          yaxt="n", # não plota eixo y,
          xlab = NA,
          ylab = NA,
          col="green",
          xlim = as.numeric(format(xl,digits = 6)),
          ylim = as.numeric(format(yl,digits = 6)))
    points(x,px,pch=16)
    points(d,pd,col = "green",pch=16)
  }
  if(out == TRUE){
    dt = data.frame(x = x, px = px)
    return(knitr::kable(dt))
  }else{
    return(invisible(NULL))
  }
}



#' Plot Geometric Distribution
#' 
#' X represent the number of failures in a sequence of Bernoulli trials before a success occurs.
#'
#' @param p probability of success in each trial. 0 < p <= 1.
#' @param n.plot number of observations for the plot, by default will be ploted 50 observations
#' @param hlt logical (default is FALSE); if TRUE, probabilities P[i ≤ X ≤ f] are highlighted in green color in the plot 
#' @param i,f highlight probability from i' initial value of distribution to 'f' final value of distribution
#'
#' @export
#'
#' @examples
#' plotGEO(p = 0.15, n.plot = 50 , hlt = FALSE, i = 2, f = 4)

plotGEO = function(p, n.plot = 50 , hlt = FALSE, i = 2, f = 4, out = TRUE){
  if (p <= 0 | p > 1) stop("'p' deve estar entre: 0 < p <= 1 ")
  n = n.plot
  x  = seq(0,n,1)
  px = dgeom(x,prob = p)
  ymax = 1.10*max(px)
  plot(x, px, 
       type = "h", 
       bty="n", 
       xaxt="n", # não plota eixo x
       yaxt="n", # não plota eixo y,
       xlab = "x",
       xlim = c(-1,n),
       ylim = c(0,ymax),
       ylab = bquote( p[X](x) ))
  
  points(x, px, pch=16)
  axis(side=1,at=seq(0,n,1),lwd.ticks = 1,lwd=3)
  #axis(side=2,at=seq(0,1,0.05),lwd=3)
  axis(side=2,lwd=3)
  # Calculo do valor esperado
  exp_value = (1-p)/p
  var_value = (1-p) / p^2
  # Legendas
  legenda <- list( bquote( "E[X] =" ~ .(exp_value)) ,
                   bquote( "V(X) =" ~ .(var_value))
  )
  
  mtext(side = 3, do.call(expression, legenda), line=-1:-2, adj=1, col=c("gray", "gray"))
  xl = par("usr")[1:2]
  yl = par("usr")[3:4]
  if(hlt == TRUE){
    par(new=TRUE)
    par(xaxs="i",yaxs="i")
    d  = i:f
    pd = px[(i+1):(f+1)]
    plot( d, pd, type="h", 
          bty="n", 
          xaxt="n", # não plota eixo x
          yaxt="n", # não plota eixo y,
          xlab = NA,
          ylab = NA,
          col="green",
          xlim = as.numeric(format(xl,digits = 6)),
          ylim = as.numeric(format(yl,digits = 6)))
    #points(x,px,pch=16)
    points(d,pd,col = "green",pch=16)
  }
  if(out == TRUE){
    dt = data.frame(x = x, px = px)
    return(knitr::kable(dt))
  }else{
    return(invisible(NULL))
  }
}



#' Plot of Hypergeometric Distribution
#'
#' X is the random variable that is equal the number of successes in the sample selected randomly (without replacement).  
#' 
#' @param N a set of N objects 
#' @param K objects classified as successes 
#' @param n a sample size of objects selected randomly (without replacement) from the set of N objects where `K <= N` and `n <= N`
#' @param hlt logical (default is FALSE); if TRUE, probabilities P[i ≤ X ≤ f] are highlighted in green color in the plot 
#' @param i,f highlight probability from i' initial value of distribution to 'f' final value of distribution
#'
#' @export
#'
#' @examples
#' plotHYPER(N = 10,K = 5,n = 5, hlt = TRUE, i = 2, f = 4)

plotHYPER = function(N,K,n, hlt = FALSE, i = 2, f = 4, out = TRUE){
  if (K >= N & n >= N) stop("'K < N' e 'n < N'")
  xmax = min(K,n)
  xmin = max(0,n+K-N)
  
  x  = seq(xmin,xmax,1)
  
  px = dhyper(x, m = K, n = N-K, k = n)
  
  ymax = 1.10*max(px)
  plot(x, px, 
       type = "h", 
       bty="n", 
       xaxt="n", # não plota eixo x
       yaxt="n", # não plota eixo y,
       xlab = "x",
       xlim = c(-0.5,xmax+0.5),
       ylim = c(0,ymax),
       ylab = bquote( p[X](x) ))
  
  points(x, px, pch=16)
  axis(side=1,at=seq(0,n,1),lwd.ticks = 1,lwd=3)
  #axis(side=2,at=seq(0,1,0.05),lwd=3)
  axis(side=2,lwd=3)
  # Calculo do valor esperado
  exp_value = n*(K/N)
  var_value = n*(K/N)*(1 - K/N)*((N-n)/(N-1))
  # Legendas
  legenda <- list( bquote( "E[X] =" ~ .(exp_value)) ,
                   bquote( "V(X) =" ~ .(var_value))
  )
  
  mtext(side = 3, do.call(expression, legenda), line=-1:-2, adj=1, col=c("gray", "gray"))
  xl = par("usr")[1:2]
  yl = par("usr")[3:4]
  if(hlt == TRUE){
    par(new=TRUE)
    par(xaxs="i",yaxs="i")
    d  = i:f
    pd = px[(i+1):(f+1)]
    plot( d, pd, type="h", 
          bty="n", 
          xaxt="n", # não plota eixo x
          yaxt="n", # não plota eixo y,
          xlab = NA,
          ylab = NA,
          col="green",
          xlim = as.numeric(format(xl,digits = 6)),
          ylim = as.numeric(format(yl,digits = 6)))
    #points(x,px,pch=16)
    points(d,pd,col = "green",pch=16)
  }
  if(out == TRUE){
    dt = data.frame(x = x, px = px)
    return(knitr::kable(dt))
  }else{
    return(invisible(NULL))
  }
}

#' Plot Poisson Distribution
#'
#' @param lambda is the mean number of events per unit length
#' @param n.plot number of observations for the plot, by default will be ploted 50 observations
#' @param hlt logical (default is FALSE); if TRUE, probabilities P[i ≤ X ≤ f] are highlighted in green color in the plot 
#' @param i,f highlight probability from i' initial value of distribution to 'f' final value of distribution 
#'
#' @export
#'
#' @examples
#' plotPOIS(lambda = 0.5, n.plot = 15, hlt = TRUE, i = 2, f = 4)

plotPOIS = function(lambda, n.plot = 50 , hlt = FALSE, i = 2, f = 4, out = TRUE){
  if (lambda <= 0) stop("'lambda' deve ser maior que 0.")
  n = n.plot
  x  = seq(0,n,1)
  px = dpois(x,lambda = lambda)
  ymax = 1.10*max(px)
  ymin = -0.05*max(px)
  plot(x, px, 
       type = "h", 
       bty="n", 
       xaxt="n", # não plota eixo x
       yaxt="n", # não plota eixo y,
       xlab = "x",
       xlim = c(-0.25,n),
       ylim = c(ymin,ymax),
       ylab = bquote( p[X](x) ))
  
  points(x, px, pch=16)
  axis(side=1,at=seq(0,n,1),lwd.ticks = 1,lwd=3)
  #axis(side=2,at=seq(0,1,0.2),lwd=3)
  axis(side=2,lwd=3)
  # Calculo do valor esperado
  exp_value = lambda
  var_value = lambda
  # Legendas
  legenda <- list( bquote( "E[X] =" ~ .(exp_value)) ,
                   bquote( "V(X) =" ~ .(var_value))
  )
  
  mtext(side = 3, do.call(expression, legenda), line=-1:-2, adj=1, col=c("gray", "gray"))
  xl = par("usr")[1:2]
  yl = par("usr")[3:4]
  if(hlt == TRUE){
    par(new=TRUE)
    par(xaxs="i",yaxs="i")
    d  = i:f
    pd = px[(i+1):(f+1)]
    plot( d, pd, type="h", 
          bty="n", 
          xaxt="n", # não plota eixo x
          yaxt="n", # não plota eixo y,
          xlab = NA,
          ylab = NA,
          col="green",
          xlim = as.numeric(format(xl,digits = 6)),
          ylim = as.numeric(format(yl,digits = 6)))
    #points(x,px,pch=16)
    points(d,pd,col = "green",pch=16)
    PX = sum(pd)
  }
  if(out == TRUE & hlt == TRUE){
    dt = data.frame(x = x, px = px)
    return(list(knitr::kable(dt),PX))
  }else if (out == TRUE & hlt == FALSE){
    dt = data.frame(x = x, px = px)
    return(knitr::kable(dt))
  }else{
    return(invisible(NULL))
    # dt = data.frame(x = x, px = px)
    # print(knitr::kable(dt))
    # return(invisible(list(tabela = knitr::kable(dt),data = dt)))
  }
}


#' Plot Empirical Distribution
#'
#' @param x random variable values
#' @param px given probabilities for the random values x
#' @param i highlight probability from i' initial value of distribution to 'f' final value of distribution 
#' @param f highlight probability from i' initial value of distribution to 'f' final value of distribution
#' @param output logical (default is FALSE); if TRUE a LaTeX formated table with probabilities is printed in console 
#' @param hlt logical (default is FALSE); if TRUE, probabilities P[i ≤ X ≤ f] are highlighted in green color in the plot 
#'
#' @export
#'
#' @examples
#' plotEMP(x = c(0, 1, 2, 3, 4, 5),px = c(0.15, 0.20, 0.25, 0.20, 0.15, 0.05))

plotEMP = function(x, px , hlt = FALSE, i = 2, f = 4, output = FALSE){
  if (!is.numeric(x))
    stop("Argument 'x' must be numeric")
  if (!is.numeric(px))
    stop("Argument 'px' must be numeric")
  ymax = 1.10*max(px)
  ymin = -0.05*max(px)
  plot(x, px, 
       type = "h", 
       bty="n", 
       xaxt="n", # não plota eixo x
       yaxt="n", # não plota eixo y,
       xlab = "x",
       ylab = bquote( p[X](x) ))
  
  points(x, px, pch=16)
  axis(side=1,at=x,lwd.ticks = 1,lwd=3)
  #axis(side=2,at=seq(0,1,0.2),lwd=3)
  axis(side=2,lwd=3)
  # Calculo do valor esperado
  exp_value = sum(x*px)
  var_value = sum((x-exp_value)^2*px)
  des_value = sqrt(var_value)
  # Legendas
  legenda <- list( bquote( "E[X] =" ~ .(exp_value)) ,
                   bquote( "V(X) =" ~ .(var_value)),
                   bquote( "DP(X) =" ~ .(des_value))
  )
  
  mtext(side = 3, do.call(expression, legenda), line=-1:-3, adj=1, col=c("gray", "gray"))
  xl = par("usr")[1:2]
  yl = par("usr")[3:4]
  if(hlt == TRUE){
    par(new=TRUE)
    par(xaxs="i",yaxs="i")
    d  = i:f
    pd = px[(i+1):(f+1)]
    plot( d, pd, type="h", 
          bty="n", 
          xaxt="n", # não plota eixo x
          yaxt="n", # não plota eixo y,
          xlab = NA,
          ylab = NA,
          col="green",
          xlim = as.numeric(format(xl,digits = 6)),
          ylim = as.numeric(format(yl,digits = 6)))
    #points(x,px,pch=16)
    points(d,pd,col = "green",pch=16)
    PX = sum(pd)
  }
  if(hlt == TRUE){
    dt = data.frame(x = x, px = px)
    return(list(knitr::kable(dt),PX))
  }else{
    dt = data.frame(x = x, px = px)
    print(knitr::kable(dt))
    return(invisible(list(tabela = knitr::kable(dt),data = dt)))
  }
}


