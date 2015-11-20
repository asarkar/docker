package name.abhijitsarkar.javaee.hello.repository;

import name.abhijitsarkar.javaee.hello.domain.City;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * @author Abhijit Sarkar
 */
public interface CityRepository extends PagingAndSortingRepository<City, Long> {
}
