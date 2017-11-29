textos = {'texto1.txt','texto2.txt','texto3.txt','texto4.txt','texto5.txt','texto6.txt','texto7.txt','texto8.txt','texto9.txt','texto10.txt','texto11.txt','texto12.txt'};
qntdtextos = 3;

words = [];
palavras = fopen('buscar.txt','r');
linew = 'line';
linew = fgetl(palavras);
words = strsplit(linew);
fclose(palavras);


for z = 1:qntdtextos
    
porcentagemword = 0.0;
porcentagemword2 = 0.0;
pontos=0;
flagvalid=0;
l=0;
maiorporcentagem=0.0;

    caminho = '';
    caminho = strcat('textos/', textos{z});
    textocompleto = fopen(caminho,'r');
    line = 'line';
    while ~feof(textocompleto)
        
        status = feof(textocompleto);
        line = fgetl(textocompleto);
        linesplited = strsplit(line);
        sizelinesplited = [];
        sizeword = [];
        sizelinesplited = size(linesplited);
        sizeword = size(words);
        maxi = sizelinesplited(2);
        maxj = sizeword(2);
        for i = 1:maxi
            for j = 1:maxj
                
                if strcmpi(linesplited(i),words(j))
                    pontos = pontos + 500
                    maiorporcentagem = 1.0
                    
                else
                    palavraarray = char(linesplited(i));
                    sizepalavraarray = size(palavraarray);
                    sizepalavra = sizepalavraarray(2);
                    wordarray = char(words(j));
                    sizewordarray = size(wordarray);
                    sizeword = sizewordarray(2);
                    if sizeword < sizepalavra
                        pontosminimos = sizeword;
                        maiorpalavra = sizepalavra;
                    else
                        pontosminimos = sizepalavra;
                        maiorpalavra = sizeword;
                    end
                    flag=0;
                    superflag=0;
                    pontospalavra = 0;
                    porcentagemword = 0.0;
                    porcentagemword2 = 0.0;
                    for k = 1:sizepalavra
                        
                        
                        if l ~= 1 && l ~= 0
                            
                            if l>sizeword
                                l=0;
                                validflag=0;
                            end
                            if l ~=0 && palavraarray(k) == wordarray(l) || l~=0 && char(palavraarray(k)-32) == wordarray(l) || l~=0 && palavraarray(k) == char(wordarray(l)-32)
                                pontospalavra = pontospalavra+1;
                                flag = flag+1;
                                l = l+1;
                                flagvalid=1;
                                if l>sizeword
                                    l=0;
                                    validflag=0;
                                end
                                
                            else
                                flag = 0;
                                l = 0;
                                flagvalid=0;
                            end
                            
                            
                            
                            if flag == 3
                                pontospalavra = pontospalavra+5;
                            elseif flag == 4
                                pontospalavra = pontospalavra+10;
                            elseif flag == 5
                                pontospalavra = pontospalavra+30;
                            elseif flag == 6
                                pontospalavra = pontospalavra+40;
                            elseif flag == 7
                                pontospalavra = pontospalavra+50;
                            elseif flag == 8
                                pontospalavra = pontospalavra+50;
                                flagvalid = 0;
                            end
                            
                            porcentagemword2 = flag/maiorpalavra;
                            if porcentagemword2 > porcentagemword
                                porcentagemword = porcentagemword2;
                            end
                            
                            if porcentagemword > maiorporcentagem
                                maiorporcentagem = porcentagemword
                            end
                            
                            if flag >= 0.75*maiorpalavra
                                superflag = 1;
                            end
                            
                        end
                        
                        if l==0
                            l=1;
                        end
                        
                        while l>0 && flagvalid == 0
                            if l>sizeword
                                l=0;
                                
                            else
                                if palavraarray(k) == wordarray(l) || char(palavraarray(k)-32) == wordarray(l) || palavraarray(k) == char(wordarray(l)-32)
                                    l = l+1;
                                    flag = flag+1;
                                    break;
                                end
                                l=l+1;
                            end
                            
                            
                        end
                        
                    end
                    
                    if pontospalavra >= pontosminimos
                        if superflag == 1
                            pontos = pontos+300
                            superflag = 0;
                            l = 0;
                            flagvalid = 0;
                        else
                            pontos = pontos+pontospalavra
                            l=0;
                            flagvalid = 0;
                        end
                    end
                end
                
            end
            
        end
        
    end
    fclose(textocompleto);
    
    
    fis = readfis('logicafuzzy.fis');
    relevancia(z) = evalfis([pontos maiorporcentagem],fis)
    
end
