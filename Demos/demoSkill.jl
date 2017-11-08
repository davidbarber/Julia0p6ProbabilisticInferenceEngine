using PyPlot
A,B,C=1,2,3 # give variables a number
Nlevels=10

function demoSkill()

    A,B,C=1,2,3 # give variables a number
    Nlevels=10

    sigmoid(x)=1./(1+exp(-x))

    pLeftPlayerWins=zeros(Nlevels,Nlevels)

    for levelleft=1:10
        for levelright=1:10
            pLeftPlayerWins[levelleft,levelright]=sigmoid(levelleft-levelright)
        end
    end

    #prior_pot=exp.(-0.05*(Nlevels/2-linspace(0,Nlevels,Nlevels)).^2) # peaked around skill 5
    prior_pot=ones(Nlevels,1) # uniform prior on skill
    prior_pot=prior_pot./sum(prior_pot)
    priorA=PotArray(A,prior_pot)
    priorB=PotArray(B,prior_pot)
    priorC=PotArray(C,prior_pot)

    fAbeatsB=PotArray([A B],pLeftPlayerWins)
    fBbeatsC=PotArray([B C],pLeftPlayerWins)
    fAbeatsC=PotArray([A C],pLeftPlayerWins)

    Data = "A>B, B>C"
    pABC=fAbeatsB*fBbeatsC*priorA*priorB*priorC
    plotstuff(Data,pABC,fAbeatsC)

    Data = "A>B, A>B"
    pABC=fAbeatsB*fAbeatsB*priorA*priorB*priorC
    plotstuff(Data,pABC,fAbeatsC)

    Data = "(A>B)^6, (B>C)^6"
    pABC=fAbeatsB^6*fBbeatsC^6*priorA*priorB*priorC
    plotstuff(Data,pABC,fAbeatsC)

    Data = "A>B, C>B"
    pABC=fAbeatsB*(1-fBbeatsC)*priorA*priorB*priorC
    plotstuff(Data,pABC,fAbeatsC)

end


    function plotstuff(Data,pABC,fAbeatsC)

        pABC=pABC./sum(pABC) # normalise
        pAC=sum(pABC,B)
        pAbeatsC=sum(fAbeatsC*pAC)
        # What is the probability that A will beat C?
        println(Data*" : probability that A beats C = $(pAbeatsC.content)")
        pA=sum(pABC,[B C]); pB=sum(pABC,[A C]); pC=sum(pABC,[B A])
        figure(); title(Data)
        plot(pA.content,label="A skill")
        plot(pB.content,label="B skill")
        plot(pC.content,label="C skill")
        legend()
        # Can calculate mean skill levels using:
        println("mean skill for A=",sum(pA.content.*(1:Nlevels))) # mean skill level for A
        println("mean skill for B=",sum(pB.content.*(1:Nlevels))) # mean skill level for B
        println("mean skill for C=",sum(pC.content.*(1:Nlevels))) # mean skill level for C
    end


