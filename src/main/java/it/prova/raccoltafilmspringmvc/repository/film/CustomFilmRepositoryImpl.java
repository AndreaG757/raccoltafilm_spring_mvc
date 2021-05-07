package it.prova.raccoltafilmspringmvc.repository.film;

import it.prova.raccoltafilmspringmvc.model.Film;
import it.prova.raccoltafilmspringmvc.model.Regista;
import org.apache.commons.lang3.StringUtils;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomFilmRepositoryImpl implements CustomFilmRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Film> findByExample(Film film) {

        Map<String, Object> paramaterMap = new HashMap<String, Object>();
        List<String> whereClauses = new ArrayList<String>();

        StringBuilder queryBuilder = new StringBuilder("select f from Film f where f.id = f.id ");

        if (StringUtils.isNotEmpty(film.getTitolo())) {
            whereClauses.add(" f.titolo like :titolo ");
            paramaterMap.put("titolo", "%" + film.getTitolo() + "%");
        }
        if (StringUtils.isNotEmpty(film.getGenere())) {
            whereClauses.add(" f.genere like :genere ");
            paramaterMap.put("genere", "%" + film.getGenere() + "%");
        }
        if (film.getDataPubblicazione() != null) {
            whereClauses.add(" f.dataPubblicazione >= :dataPubblicazione ");
            paramaterMap.put("dataPubblicazione", film.getDataPubblicazione());
        }
        if (film.getMinutiDurata() != null) {
            whereClauses.add(" f.minutiDurata = :minutiDurata ");
            paramaterMap.put("minutiDurata", film.getMinutiDurata());
        }
        if (film.getRegista().getId() != null) {
            whereClauses.add("f.regista = :regista ");
            paramaterMap.put("regista", film.getRegista());
        }

        queryBuilder.append(!whereClauses.isEmpty()?" and ":"");
        queryBuilder.append(StringUtils.join(whereClauses, " and "));
        TypedQuery<Film> typedQuery = entityManager.createQuery(queryBuilder.toString(), Film.class);

        for (String key : paramaterMap.keySet()) {
            typedQuery.setParameter(key, paramaterMap.get(key));
        }

        return typedQuery.getResultList();

    }

}
