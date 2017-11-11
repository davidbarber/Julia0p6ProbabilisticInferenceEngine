function demoCars()

    wife,husband,income=1,2,3 # give variables a number

    pi=PotArray(income,[0.8 0.2]) # income distribution
    phgi=PotArray([husband income],[0.2 0; 0.8 0; 0 0.3; 0 0.7]) # p(husband_car|income)
    pwgi=PotArray([wife,income],[0.7 0.2; 0.3 0.1; 0 0.4; 0 0.3]) # p(wife_car|income)
    joint=pwgi*phgi*pi # p(wife_car,husband_car,income)=p(wife_car|income)p(husband_car|income)p(income)
    pwh=sum(joint,income)

    #
    println("Check if w is independent of h.  mean(|p(w,h)-p(w)p(h)|) :")
    println(mean(abs.((pwh-sum(pwh,husband)*sum(pwh,wife)).content)))
    println("This is not zero, so w and h are dependent")

end
