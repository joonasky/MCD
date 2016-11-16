# LASKENNALLISEN FYSIIKAN OHJELMATYÖ:
## Diffuusion Monte Carlo -simulointi yksiulotteisessa systeemissä 

### Kääntäminen ja ajaminen
Ohjelman kääntämiseen tarvitsee [gfortran]-kääntäjän ja [make]n. Ohjelman voi kääntää kommennolla
```sh
$ make
```
ja ajaa komennoilla 
```sh
$ ./runner.sh
$ ./runner2.sh
$ ./runner3.sh
```
Sen jälkeen kun nille on antanut oikeudet komennolla
```sh
$ chmod +x runner*
```
Scriptit voi ajaa eri terminaaleissa niin tietokone jossa on monta ydintä voi ajaa simulaatiot läpi tehokkaammin.
Kutsun tätä *teekkarin paralelisoinniksi*
### SISÄLTÖ
- Kansio **src/** sisältää lähdekoodit. 
- Kansio  **run/** sisältää ohjelman ajamisen tuottaman datan.

[gfortran]: <https://gcc.gnu.org/fortran/>
[make]: <https://www.gnu.org/software/make/>
