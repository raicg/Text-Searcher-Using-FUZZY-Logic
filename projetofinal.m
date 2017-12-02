function projetofinal()

textos = {'texto1.txt','texto2.txt','texto3.txt','texto4.txt','texto5.txt','texto6.txt','texto7.txt','texto8.txt','texto9.txt','texto10.txt','texto11.txt','texto12.txt','texto13.txt','texto14.txt','texto15.txt','texto16.txt','texto17.txt','texto18.txt','texto19.txt','texto20.txt','texto21.txt','texto22.txt','texto23.txt','texto24.txt','texto25.txt','texto26.txt','texto27.txt','texto28.txt','texto29.txt','texto30.txt'};
config = fopen('config.txt','r');
line = fgetl(config);
linesplited = strsplit(line);
qntdtextos = str2num(linesplited{3});
fclose(config);
words = [];
palavras = fopen('buscar.txt','r');
linew = 'line';
linew = fgetl(palavras);
words = strsplit(linew);
fclose(palavras);

palavras_relevantes = {};
palavras_relevantes_porcentagem = [];
palavras_relevantes_pontos = [];
contagem_palavras_relevantes = [];
for z = 1:qntdtextos
    contagem_palavras_relevantes(z) = 0;
end
contador = 1;

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
                    pontos = pontos + 500;
                    maiorporcentagem = 1.0;
                    porcentagemword = 1.0;
                    pontospalavra = 500;
                    palavras_relevantes{contador} = linesplited(i);
                    palavras_relevantes_porcentagem(contador) = porcentagemword;
                    palavras_relevantes_pontos(contador) = pontospalavra;
                    contagem_palavras_relevantes(qntdtextos) = contagem_palavras_relevantes(qntdtextos) +1;
                    contador = contador+1;
                    
                    
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
                            elseif porcentagemword2 <= porcentagemword && pontospalavra >= 40
                                palavras_relevantes{contador} = linesplited(i);
                                palavras_relevantes_porcentagem(contador) = porcentagemword;
                                contagem_palavras_relevantes(qntdtextos) = contagem_palavras_relevantes(qntdtextos) +1;
                                contador = contador+1;
                                
                            end
                            
                            if porcentagemword > maiorporcentagem
                                maiorporcentagem = porcentagemword;
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
                            pontos = pontos+300;
                            pontospalavra = 300;
                            palavras_relevantes_pontos(contagem-1) = pontospalavra;
                            superflag = 0;
                            l = 0;
                            flagvalid = 0;
                        else
                            pontos = pontos+pontospalavra;
                            if pontospalavra>=40
                                palavras_relevantes_pontos(contagem-1) = pontospalavra;
                            end
                            l=0;
                            flagvalid = 0;
                        end
                    end
                end
                
            end
            
        end
        
    end
    fclose(textocompleto);
    
    fis = readfis('fuzzy/logicafuzzy.fis');
    relevancia(z) = evalfis([pontos maiorporcentagem],fis);
    
end

resultados = fopen('resultados/resultados.txt','w');
fprintf(resultados, '%s\r\n', 'A revelância de cada texto encontra-se abaixo:');
fprintf(resultados, '%s\r\n', ' ');
fprintf(resultados, '%s\r\n', ' ');
for r = 1:qntdtextos
    fprintf(resultados, '%s', textos{r});
    fprintf(resultados, '%s', ' : ');
    fprintf(resultados, '%f\r\n', relevancia(r));
    fprintf(resultados, '%s\r\n', ' ');
end

fclose(resultados);

resultados_detalhados = fopen('resultados/resultados_detalhados.txt','w');

fprintf(resultados_detalhados, '%s\r\n', 'Abaixo encontram-se as palavras que apresentaram uma boa relevancia de busca para cada texto:');
fprintf(resultados_detalhados, '%s\r\n', ' ');
fprintf(resultados_detalhados, '%s\r\n', '[ PALAVRA , PORCENTAGEM , PONTOS ]');
fprintf(resultados_detalhados, '%s\r\n', ' ');
fprintf(resultados_detalhados, '%s\r\n', 'Palavra: a palavra achada no texto;');
fprintf(resultados_detalhados, '%s\r\n', ' ');
fprintf(resultados_detalhados, '%s\r\n', 'Porcentagem: a porcentagem de igualdade da palavra no texto com relação a uma das palavras da busca;');
fprintf(resultados_detalhados, '%s\r\n', ' ');
fprintf(resultados_detalhados, '%s\r\n', 'Pontos: quantidade de pontos atribuida a essa palavra.');
fprintf(resultados_detalhados, '%s\r\n', ' ');

fprintf(resultados_detalhados, '%s\r\n', ' ');
fprintf(resultados_detalhados, '%s\r\n', ' ');


size_palavras_relevantes = size(palavras_relevantes);

for r = 1:qntdtextos
    fprintf(resultados_detalhados, '%s\r\n', ' ');
    fprintf(resultados_detalhados, '%s\r\n', ' ');
    fprintf(resultados_detalhados, '%s', textos{r});
    fprintf(resultados_detalhados, '%s', ' : ');
    fprintf(resultados_detalhados, '%f\r\n', relevancia(r));
    contagem = 0;
    if contagem_palavras_relevantes(r) ~= 0
        for rr = 1:contagem_palavras_relevantes(r)
            if contagem <= contagem_palavras_relevantes(r)
                contagem = contagem+1;
                fprintf(resultados_detalhados, '%s\r\n', ' ');
                fprintf(resultados_detalhados, '%s', '[');
                fprintf(resultados_detalhados, '%s', palavras_relevantes{rr}{:});
                fprintf(resultados_detalhados, '%s', ' , ');
                fprintf(resultados_detalhados, '%f', palavras_relevantes_porcentagem(rr));
                fprintf(resultados_detalhados, '%s', ' , ');
                fprintf(resultados_detalhados, '%d', palavras_relevantes_pontos(rr));
                fprintf(resultados_detalhados, '%s\r\n', ']');
                fprintf(resultados_detalhados, '%s\r\n', ' ');
            end
        end
    end
    if contagem == 0
        fprintf(resultados_detalhados, '%s\r\n', ' ');
        fprintf(resultados_detalhados, '%s\r\n', 'Apesar de ter recebido uma relevância, esse texto não possui palavras com alta relevância.');
        fprintf(resultados_detalhados, '%s\r\n', ' ');
    end
end
fclose(resultados_detalhados);

disp(' ')
disp('pesquisa concluida!')

relevancia()
disp('Voce pode encontrar um resultado detalhado para sua pesquisa na pasta resultados')


